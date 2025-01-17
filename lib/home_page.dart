/*import 'package:flutter/material.dart';
import 'pie_chart_page.dart';
import 'statistics_page.dart';  // Yeni sayfa import ediliyor.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  String _selectedCategory = 'Ev'; // Default category
  String _selectedType = 'Gelir'; // Default type

  final Map<String, double> incomeData = {'Ev': 0.0, 'Araba': 0.0, 'Fatura': 0.0};
  final Map<String, double> expenseData = {'Ev': 0.0, 'Araba': 0.0, 'Fatura': 0.0};

  List<String> categories = ['Ev', 'Araba', 'Fatura'];

  // İşlem verilerini tarih bazında saklayacağız
  List<Map<String, dynamic>> transactions = []; // [{amount, type, category, date}]

  void _addCategory() {
    if (_categoryController.text.isEmpty) return;
    setState(() {
      categories.add(_categoryController.text);
      incomeData[_categoryController.text] = 0.0;
      expenseData[_categoryController.text] = 0.0;
      _categoryController.clear();
    });
  }

  void _addTransaction() {
    if (_amountController.text.isEmpty) return;
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0) {
      setState(() {
        // Veriye tarih ekleniyor
        String date = DateTime.now().toString(); // Şu anki tarih
        transactions.add({
          'amount': amount,
          'type': _selectedType,
          'category': _selectedCategory,
          'date': date,
        });

        if (_selectedType == 'Gelir') {
          incomeData[_selectedCategory] = (incomeData[_selectedCategory] ?? 0.0) + amount;
        } else {
          expenseData[_selectedCategory] = (expenseData[_selectedCategory] ?? 0.0) + amount;
        }
      });
    }
  }

  void _showPieChartPage(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PieChartPage(
          incomeData: incomeData,
          expenseData: expenseData,
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
        builder: (context) => StatisticsPage(transactions: transactions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finanscım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Kategori Seçin:'),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Yeni Kategori Ekle:'),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori Adı',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Kategori Ekle'),
            ),
            SizedBox(height: 10),
            Text('Gelir/Gider Seçin:'),
            Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text('Gelir'),
                  selected: _selectedType == 'Gelir',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gelir';
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Gider'),
                  selected: _selectedType == 'Gider',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gider';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text('Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gelir'),
              child: Text('Gelir Grafiğini Göster'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gider'),
              child: Text('Gider Grafiğini Göster'),
            ),
            SizedBox(height: 20),
            // İstatistikler butonu
            ElevatedButton(
              onPressed: _showStatisticsPage,
              child: Text('İstatistikleri Göster'),
            ),
          ],
        ),
      ),
    );
  }
}*/

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

  String _selectedCategory = 'Ev'; // Default category
  String _selectedType = 'Gelir'; // Default type

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
        // Veriye tarih ekleniyor
        String date = DateTime.now().toString(); // Şu anki tarih
        transactions.add(Transaction(
          amount: amount,
          type: _selectedType,
          category: _selectedCategory,
          date: datetime,
        ));
      });
    }
  }

  void _showPieChartPage(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PieChartPage(
          transactions: transactions,  // transactions iletildi
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
        title: Text('Finanscım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Kategori Seçin:'),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Yeni Kategori Ekle:'),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori Adı',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Kategori Ekle'),
            ),
            SizedBox(height: 10),
            Text('Gelir/Gider Seçin:'),
            Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text('Gelir'),
                  selected: _selectedType == 'Gelir',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gelir';
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Gider'),
                  selected: _selectedType == 'Gider',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gider';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text('Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gelir'),
              child: Text('Gelir Grafiğini Göster'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gider'),
              child: Text('Gider Grafiğini Göster'),
            ),
            SizedBox(height: 20),
            // İstatistikler butonu
            ElevatedButton(
              onPressed: _showStatisticsPage,
              child: Text('İstatistikleri Göster'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';//son temiz kod yeni tasarımdan önce
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
        // Veriye tarih ekleniyor
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
          transactions: transactions,  // transactions iletildi
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
        title: Text('Finanscım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Kategori Seçin:'),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text('Yeni Kategori Ekle:'),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori Adı',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Kategori Ekle'),
            ),
            SizedBox(height: 10),
            Text('Gelir/Gider Seçin:'),
            Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text('Gelir'),
                  selected: _selectedType == 'Gelir',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gelir';
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Gider'),
                  selected: _selectedType == 'Gider',
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedType = 'Gider';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Miktar',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: Text('Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gelir'),
              child: Text('Gelir Grafiğini Göster'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showPieChartPage('Gider'),
              child: Text('Gider Grafiğini Göster'),
            ),
            SizedBox(height: 20),
            // İstatistikler butonu
            ElevatedButton(
              onPressed: _showStatisticsPage,
              child: Text('İstatistikleri Göster'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
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
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Yeni Kategori Ekle:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori Adı',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addCategory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('Kategori Ekle', style: TextStyle(fontSize: 16)),
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
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('Ekle', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showPieChartPage('Gelir'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('Gelir Grafiğini Göster', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _showPieChartPage('Gider'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('Gider Grafiğini Göster', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showStatisticsPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('İstatistikleri Göster', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



