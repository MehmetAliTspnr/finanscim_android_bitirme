import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'pie_chart_page.dart';
import 'statistics_page.dart';
import 'transaction.dart'; // Transaction modelini import ediyoruz

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  String _selectedCategory = 'Ev'; // Default kategori
  String _selectedType = 'Gelir'; // Default işlem tipi

  List<String> categories = ['Ev', 'Araba', 'Fatura'];

  // İşlem verilerini tarih bazında saklayacağız
  List<Transaction> transactions = []; // Transaction modeline göre veri

  // Yeni kategori ekleme fonksiyonu
  void _addCategory() {
    if (_categoryController.text.isEmpty) return;
    setState(() {
      categories.add(_categoryController.text);
      _categoryController.clear();
    });
  }

  // Firestore'a veri ekleme fonksiyonu
  Future<void> addTransactions(List<Transaction> transactions) async {
    try {
      for (var transaction in transactions) {
        // Veriyi eklemeden önce Firestore'dan veriyi kontrol et
        var snapshot = await fs.FirebaseFirestore.instance
            .collection('transactions')
            .where('amount', isEqualTo: transaction.amount)
            .where('date', isEqualTo: transaction.date)
            .get();

        if (snapshot.docs.isEmpty) {
          // Eğer mevcutta yoksa, yeni veriyi ekle
          await fs.FirebaseFirestore.instance.collection('transactions').add({
            'amount': transaction.amount,
            'date': transaction.date,
            'type': transaction.type,
            'type_two': transaction.type_two,
            'sonuc': transaction.sonuc,
          });
        } else {
          print("Bu veri zaten mevcut, eklenmedi.");
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veriler başarıyla eklendi!')),
      );
    } catch (e) {
      print("Veri eklenirken hata oluştu: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veri eklenirken hata oluştu.')),
      );
    }
  }

  // İşlem ekleme fonksiyonu
  void _addTransaction() {
    if (_amountController.text.isEmpty) return;
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0) {
      setState(() {
        DateTime date = DateTime.now(); // Şu anki tarih
        transactions.add(Transaction(
          amount: amount,
          type: _selectedType,
          category: _selectedCategory,
          type_two: _selectedCategory,
          sonuc: amount,
          date: date, // DateTime tipi ile saklanıyor
        ));
      });
      addTransactions([transactions.last]); // Yalnızca son işlemi ekliyoruz
    }
  }

  // Grafik sayfasına geçiş fonksiyonu
  void _showPieChartPage(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PieChartPage(
          transactions: transactions,
          type: type,
          categories: categories,
        ),
      ),
    );
  }

  // İstatistikler sayfasına geçiş fonksiyonu
  void _showStatisticsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatisticsPage(
          transactions: transactions, // transactions iletildi
        ),
      ),
    );
  }

  void _showCategoriesPage() {
    print("Kategoriler butonuna tıklanmış!");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FİNANSCIM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Kategori Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                height: screenHeight * 0.08,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = categories[index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                        decoration: BoxDecoration(
                          color: _selectedCategory == categories[index]
                              ? Colors.blueAccent
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == categories[index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text('Yeni Kategori Ekle:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.04),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton(
                  onPressed: _addCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.015),
                  ),
                  child: Text('Kategori Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text('Gelir/Gider Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  ChoiceChip(
                    label: Text('Gelir', style: TextStyle(fontSize: 16)),
                    selected: _selectedType == 'Gelir',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedType = 'Gelir';
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  ChoiceChip(
                    label: Text('Gider', style: TextStyle(fontSize: 16)),
                    selected: _selectedType == 'Gider',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedType = 'Gider';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Miktar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.04),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.015),
                  ),
                  child: Text('Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gelir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.015),
                    ),
                    child: Text('Gelir Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gider'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.015),
                    ),
                    child: Text('Gider Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton(
                  onPressed: _showStatisticsPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.015),
                  ),
                  child: Text('İstatistikler', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton(
                  onPressed: _showCategoriesPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.015),
                  ),
                  child: Text('Kategoriler', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





