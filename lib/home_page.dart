/*import 'package:flutter/material.dart';
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

  void _addCategory() {
    if (_categoryController.text.isEmpty) return;
    setState(() {
      categories.add(_categoryController.text);
      _categoryController.clear();
    });
  }

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
          date: date, // DateTime tipi ile saklanıyor
        ));
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Başlık ortalanır
        title: Text('Finanscım', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.blueAccent, // Uygulama çubuğu rengi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Sayfayı kaydırılabilir yapar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Kategori Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              // Horizontal ListView for category selection
              Container(
                height: 60, // Yükseklik, görünümü iyileştirmek için ayarlandı
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = categories[index]; // Kategoriyi seç
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedCategory == categories[index]
                              ? Colors.blueAccent // Seçilen kategoriye farklı renk
                              : Colors.grey[200], // Diğer kategoriler için gri
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
              SizedBox(height: 20),
              Text('Yeni Kategori Ekle:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Kenar yumuşatıldı
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _addCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                  ),
                  child: Text('Kategori Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
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
                  SizedBox(width: 10),
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
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Miktar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 170, vertical: 12),
                  ),
                  child: Text('Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gelir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Buton rengi
                      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                    ),
                    child: Text('Gelir Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gider'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Buton rengi
                      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                    ),
                    child: Text('Gider Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(height: 2),
              Center(
                child: ElevatedButton(
                  onPressed: _showStatisticsPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                  ),
                  child: Text('İstatistikler', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/




// home_page.dart
import 'package:flutter/material.dart';
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

  void _addCategory() {
    if (_categoryController.text.isEmpty) return;
    setState(() {
      categories.add(_categoryController.text);
      _categoryController.clear();
    });
  }

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
          type_two: _selectedType,
          sonuc: amount,
          date: date, // DateTime tipi ile saklanıyor
        ));
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Başlık ortalanır
        title: Text('Finanscım', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.blueAccent, // Uygulama çubuğu rengi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Sayfayı kaydırılabilir yapar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Kategori Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                height: 60, // Yükseklik, görünümü iyileştirmek için ayarlandı
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = categories[index]; // Kategoriyi seç
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedCategory == categories[index]
                              ? Colors.blueAccent // Seçilen kategoriye farklı renk
                              : Colors.grey[200], // Diğer kategoriler için gri
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
              SizedBox(height: 20),
              Text('Yeni Kategori Ekle:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _addCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                  ),
                  child: Text('Kategori Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
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
                  SizedBox(width: 10),
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
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Miktar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Buton rengi
                    padding: EdgeInsets.symmetric(horizontal: 170, vertical: 12),
                  ),
                  child: Text('Ekle', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons evenly
                children: [
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gelir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                    ),
                    child: Text('Gelir Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPieChartPage('Gider'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                    ),
                    child: Text('Gider Grafiği', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(height: 2),
              Center(
                child: ElevatedButton(
                  onPressed: _showStatisticsPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                  ),
                  child: Text('İstatistikler', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
