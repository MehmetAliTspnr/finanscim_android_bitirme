/*import 'package:flutter/material.dart';
import 'transaction.dart'; // Transaction modelini import ediyoruz
import 'package:intl/intl.dart'; // Tarih formatı için

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({
    required this.transactions,
  });

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily'; // Varsayılan olarak 'Günlük' seçili

  // Tarihleri filtreleme fonksiyonları
  List<Transaction> filterTransactionsByDate(DateTime start, DateTime end) {
    return widget.transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  // Günlük veriyi alıyoruz
  List<Transaction> getDailyTransactions() {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(startOfDay, endOfDay);
  }

  // Haftalık veriyi alıyoruz
  List<Transaction> getWeeklyTransactions() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(startOfWeek, endOfWeek);
  }

  // Aylık veriyi alıyoruz
  List<Transaction> getMonthlyTransactions() {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(startOfMonth, endOfMonth);
  }

  // Gelir ve gider hesaplama fonksiyonu
  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    // Seçilen döneme göre verileri alıyoruz
    List<Transaction> transactionsToDisplay;
    String periodLabel;
    switch (selectedPeriod) {
      case 'Weekly':
        transactionsToDisplay = getWeeklyTransactions();
        periodLabel = 'Haftalık Veriler:';
        break;
      case 'Monthly':
        transactionsToDisplay = getMonthlyTransactions();
        periodLabel = 'Aylık Veriler:';
        break;
      default:
        transactionsToDisplay = getDailyTransactions();
        periodLabel = 'Günlük Veriler:';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Seçilen döneme göre başlık ve tarih
            Text(
              periodLabel,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              selectedPeriod == 'Daily'
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : selectedPeriod == 'Weekly'
                  ? '${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))} - ${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)))}'
                  : DateFormat('yyyy-MM').format(DateTime.now()),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Gelir ve gider bilgileri
            Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
            Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
            SizedBox(height: 10),

            // Net durum (Gelir - Gider)
            Text(
              'Net Durum: ${calculateNet(transactionsToDisplay)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Dönem seçimi butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Daily';
                    });
                  },
                  child: Text('Günlük'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Weekly';
                    });
                  },
                  child: Text('Haftalık'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Monthly';
                    });
                  },
                  child: Text('Aylık'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs; // Firebase'den gelen Transaction'a alias verdik
import 'package:intl/intl.dart'; // Tarih formatı için
import 'transaction.dart'; // Kendi Transaction modelini import ediyoruz

// Firebase'e veri ekleme fonksiyonu

Future<void> addTransaction(Transaction transaction) async {
  try {
    // Firestore koleksiyonuna veri ekliyoruz
    await fs.FirebaseFirestore.instance
        .collection('transactions') // Koleksiyon ismi
        .add({
      'amount': transaction.amount,
      'date': transaction.date,
      'type': transaction.type,
    });
  } catch (e) {
    print("Veri eklerken hata oluştu: $e");
  }
}

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({
    required this.transactions,
  });

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily'; // Varsayılan olarak 'Günlük' seçili

  // Tarihleri filtreleme fonksiyonları
  List<Transaction> filterTransactionsByDate(DateTime start, DateTime end) {
    return widget.transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  // Günlük veriyi alıyoruz
  List<Transaction> getDailyTransactions() {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(startOfDay, endOfDay);
  }

  // Haftalık veriyi alıyoruz
  List<Transaction> getWeeklyTransactions() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(startOfWeek, endOfWeek);
  }

  // Aylık veriyi alıyoruz
  List<Transaction> getMonthlyTransactions() {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(startOfMonth, endOfMonth);
  }

  // Gelir ve gider hesaplama fonksiyonu
  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    // Seçilen döneme göre verileri alıyoruz
    List<Transaction> transactionsToDisplay;
    String periodLabel;
    switch (selectedPeriod) {
      case 'Weekly':
        transactionsToDisplay = getWeeklyTransactions();
        periodLabel = 'Haftalık Veriler:';
        break;
      case 'Monthly':
        transactionsToDisplay = getMonthlyTransactions();
        periodLabel = 'Aylık Veriler:';
        break;
      default:
        transactionsToDisplay = getDailyTransactions();
        periodLabel = 'Günlük Veriler:';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Seçilen döneme göre başlık ve tarih
            Text(
              periodLabel,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              selectedPeriod == 'Daily'
                  ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                  : selectedPeriod == 'Weekly'
                  ? '${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))} - ${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)))}'
                  : DateFormat('yyyy-MM').format(DateTime.now()),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            // Gelir ve gider bilgileri
            Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
            Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
            SizedBox(height: 10),

            // Net durum (Gelir - Gider)
            Text(
              'Net Durum: ${calculateNet(transactionsToDisplay)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Dönem seçimi butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Daily';
                    });
                  },
                  child: Text('Günlük'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Weekly';
                    });
                  },
                  child: Text('Haftalık'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Monthly';
                    });
                  },
                  child: Text('Aylık'),
                ),
              ],
            ),

            // Firebase'e veri eklemek için buton
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Seçilen dönem için toplam gelir değerini hesaplıyoruz
                double totalIncome = calculateIncome(transactionsToDisplay);

                // Yeni Transaction nesnesini oluşturuyoruz
                Transaction newTransaction = Transaction(
                  date: DateTime.now(),
                  type: 'Gelir',
                  amount: totalIncome, // Toplam geliri amount alanına atıyoruz
                  category: 'Uncategorized',
                );

                // Veriyi Firebase'e gönderiyoruz
                addTransaction(newTransaction);
              },
              child: Text('Yeni İşlem Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs; // Firebase Firestore kütüphanesi
//import 'package:intl/intl.dart'; // Tarih formatı için
import 'transaction.dart'; // Transaction modelinizi import edin

// Firebase'den verileri okuma fonksiyonu
Future<List<Transaction>> fetchTransactions() async {
  List<Transaction> transactions = [];
  try {
    var snapshot = await fs.FirebaseFirestore.instance
        .collection('transactions')
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      transactions.add(Transaction(
        amount: (data['amount'] as num?)?.toDouble() ?? 0.0, // num'dan double'a
        date: (data['date'] as fs.Timestamp).toDate(), // Timestamp'i DateTime'a çevir
        type: data['type'] ?? '', // Varsayılan boş string
        category: data['type_two'] ?? 'Uncategorized', // Varsayılan kategori
        sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0, // num'dan double'a
        type_two: data['type_two'] ?? '', // Varsayılan boş string
      ));
    }
  } catch (e) {
    print("Veri alınırken hata oluştu: $e");
  }
  return transactions;
}


class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions; // Transaction listesi parametresi

  StatisticsPage({required this.transactions});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily'; // Varsayılan seçim
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = fetchTransactions(); // Firebase'den veriyi getir
  }

  // Tarih filtreleme
  List<Transaction> filterTransactionsByDate(
      List<Transaction> transactions, DateTime start, DateTime end) {
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  // Günlük veriler
  List<Transaction> getDailyTransactions(List<Transaction> transactions) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(transactions, startOfDay, endOfDay);
  }

  // Haftalık veriler
  List<Transaction> getWeeklyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(transactions, startOfWeek, endOfWeek);
  }

  // Aylık veriler
  List<Transaction> getMonthlyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(transactions, startOfMonth, endOfMonth);
  }

  // Gelir, gider ve net hesaplama
  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            List<Transaction> transactions = snapshot.data!;

            // Seçilen döneme göre filtreleme
            List<Transaction> transactionsToDisplay;
            String periodLabel;
            switch (selectedPeriod) {
              case 'Weekly':
                transactionsToDisplay = getWeeklyTransactions(transactions);
                periodLabel = 'Haftalık Veriler';
                break;
              case 'Monthly':
                transactionsToDisplay = getMonthlyTransactions(transactions);
                periodLabel = 'Aylık Veriler';
                break;
              default:
                transactionsToDisplay = getDailyTransactions(transactions);
                periodLabel = 'Günlük Veriler';
                break;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    periodLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
                  Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
                  SizedBox(height: 10),
                  Text(
                    'Net Durum: ${calculateNet(transactionsToDisplay)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Daily';
                          });
                        },
                        child: Text('Günlük'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Weekly';
                          });
                        },
                        child: Text('Haftalık'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Monthly';
                          });
                        },
                        child: Text('Aylık'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

 */

/*//+ lı olan
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';

// Firebase'den verileri okuma fonksiyonu
Future<List<Transaction>> fetchTransactions() async {
  List<Transaction> transactions = [];
  try {
    var snapshot = await fs.FirebaseFirestore.instance
        .collection('transactions')
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();
      transactions.add(Transaction(
        amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
        date: (data['date'] as fs.Timestamp).toDate(),
        type: data['type'] ?? '',
        category: data['category'] ?? 'Uncategorized',
        sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
        type_two: data['type_two'] ?? '',
      ));
    }
  } catch (e) {
    print("Veri alınırken hata oluştu: $e");
  }
  return transactions;
}

// Firebase'e veri ekleme fonksiyonu
Future<void> addTransaction(Transaction transaction) async {
  try {
    await fs.FirebaseFirestore.instance.collection('transactions').add({
      'amount': transaction.amount,
      'date': transaction.date,
      'type': transaction.type,
      'category': transaction.category,
      'sonuc': transaction.sonuc,
      'type_two': transaction.type_two,
    });
    print("Veri başarıyla eklendi.");
  } catch (e) {
    print("Veri eklenirken hata oluştu: $e");
  }
}

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({required this.transactions});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily';
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = fetchTransactions();
  }

  List<Transaction> filterTransactionsByDate(
      List<Transaction> transactions, DateTime start, DateTime end) {
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  List<Transaction> getDailyTransactions(List<Transaction> transactions) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(transactions, startOfDay, endOfDay);
  }

  List<Transaction> getWeeklyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(transactions, startOfWeek, endOfWeek);
  }

  List<Transaction> getMonthlyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(transactions, startOfMonth, endOfMonth);
  }

  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  void showAddTransactionDialog() {
    final _formKey = GlobalKey<FormState>();
    double amount = 0.0;
    String type = 'Gelir';
    String category = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Yeni İşlem Ekle'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tutar'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tutar giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    amount = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Kategori'),
                  onSaved: (value) {
                    category = value ?? '';
                  },
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  items: ['Gelir', 'Gider']
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) {
                    type = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  addTransaction(Transaction(
                    amount: amount,
                    date: DateTime.now(),
                    type: type,
                    category: category,
                    sonuc: 0.0,
                    type_two: '',
                  ));
                  Navigator.of(context).pop();
                  setState(() {
                    transactionsFuture = fetchTransactions();
                  });
                }
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            List<Transaction> transactions = snapshot.data!;

            List<Transaction> transactionsToDisplay;
            String periodLabel;
            switch (selectedPeriod) {
              case 'Weekly':
                transactionsToDisplay = getWeeklyTransactions(transactions);
                periodLabel = 'Haftalık Veriler';
                break;
              case 'Monthly':
                transactionsToDisplay = getMonthlyTransactions(transactions);
                periodLabel = 'Aylık Veriler';
                break;
              default:
                transactionsToDisplay = getDailyTransactions(transactions);
                periodLabel = 'Günlük Veriler';
                break;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    periodLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
                  Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
                  SizedBox(height: 10),
                  Text(
                    'Net Durum: ${calculateNet(transactionsToDisplay)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Daily';
                          });
                        },
                        child: Text('Günlük'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Weekly';
                          });
                        },
                        child: Text('Haftalık'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Monthly';
                          });
                        },
                        child: Text('Aylık'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTransactionDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({required this.transactions});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily';
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    // Verileri çekmek için fetchTransactions fonksiyonunu çağırıyoruz
    transactionsFuture = fetchTransactions();
  }

  // Verileri Firestore'dan çekme fonksiyonu
  Future<List<Transaction>> fetchTransactions() async {
    List<Transaction> transactions = [];
    try {
      var snapshot = await fs.FirebaseFirestore.instance
          .collection('transactions')
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        transactions.add(Transaction(
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as fs.Timestamp).toDate(),
          type: data['type'] ?? '',
          category: data['type_two'] ?? 'Uncategorized',
          sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
          type_two: data['type_two'] ?? '',
        ));
      }
    } catch (e) {
      print("Veri alınırken hata oluştu: $e");
    }
    return transactions;
  }

  // Veriyi sadece ekleme işlemi (eski verileri silmeden)
  Future<void> addTransactions(List<Transaction> transactions) async {
    try {
      for (var transaction in transactions) {
        await fs.FirebaseFirestore.instance.collection('transactions').add({
          'amount': transaction.amount,
          'date': transaction.date,
          'type': transaction.type,
          'type_two': transaction.type_two,
          'sonuc': transaction.sonuc,
        });
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

  List<Transaction> filterTransactionsByDate(
      List<Transaction> transactions, DateTime start, DateTime end) {
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  List<Transaction> getDailyTransactions(List<Transaction> transactions) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(transactions, startOfDay, endOfDay);
  }

  List<Transaction> getWeeklyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(transactions, startOfWeek, endOfWeek);
  }

  List<Transaction> getMonthlyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(transactions, startOfMonth, endOfMonth);
  }

  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider') // Burada 'type' doğru alan adı olmalı
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            List<Transaction> transactions = snapshot.data!;

            List<Transaction> transactionsToDisplay;
            String periodLabel;
            switch (selectedPeriod) {
              case 'Weekly':
                transactionsToDisplay = getWeeklyTransactions(transactions);
                periodLabel = 'Haftalık Veriler';
                break;
              case 'Monthly':
                transactionsToDisplay = getMonthlyTransactions(transactions);
                periodLabel = 'Aylık Veriler';
                break;
              default:
                transactionsToDisplay = getDailyTransactions(transactions);
                periodLabel = 'Günlük Veriler';
                break;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    periodLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
                  Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
                  SizedBox(height: 10),
                  Text(
                    'Net Durum: ${calculateNet(transactionsToDisplay)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Daily';
                          });
                        },
                        child: Text('Günlük'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Weekly';
                          });
                        },
                        child: Text('Haftalık'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Monthly';
                          });
                        },
                        child: Text('Aylık'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => addTransactions(widget.transactions),
                      child: Text('Veri Güncelle'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({required this.transactions});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily';
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = fetchTransactions();
  }

  // Verileri Firestore'dan çekme fonksiyonu
  Future<List<Transaction>> fetchTransactions() async {
    List<Transaction> transactions = [];
    try {
      var snapshot = await fs.FirebaseFirestore.instance
          .collection('transactions')
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        transactions.add(Transaction(
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as fs.Timestamp).toDate(),
          type: data['type'] ?? '',
          category: data['type_two'] ?? 'Uncategorized',
          sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
          type_two: data['type_two'] ?? '',
        ));
      }
    } catch (e) {
      print("Veri alınırken hata oluştu: $e");
    }
    return transactions;
  }

  // Veriyi sadece ekleme işlemi (eski verileri silmeden)
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

  List<Transaction> filterTransactionsByDate(
      List<Transaction> transactions, DateTime start, DateTime end) {
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  List<Transaction> getDailyTransactions(List<Transaction> transactions) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(transactions, startOfDay, endOfDay);
  }

  List<Transaction> getWeeklyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(transactions, startOfWeek, endOfWeek);
  }

  List<Transaction> getMonthlyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(transactions, startOfMonth, endOfMonth);
  }

  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            List<Transaction> transactions = snapshot.data!;

            List<Transaction> transactionsToDisplay;
            String periodLabel;
            switch (selectedPeriod) {
              case 'Weekly':
                transactionsToDisplay = getWeeklyTransactions(transactions);
                periodLabel = 'Haftalık Veriler';
                break;
              case 'Monthly':
                transactionsToDisplay = getMonthlyTransactions(transactions);
                periodLabel = 'Aylık Veriler';
                break;
              default:
                transactionsToDisplay = getDailyTransactions(transactions);
                periodLabel = 'Günlük Veriler';
                break;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    periodLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
                  Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
                  SizedBox(height: 10),
                  Text(
                    'Net Durum: ${calculateNet(transactionsToDisplay)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Daily';
                          });
                        },
                        child: Text('Günlük'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Weekly';
                          });
                        },
                        child: Text('Haftalık'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Monthly';
                          });
                        },
                        child: Text('Aylık'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => addTransactions(widget.transactions),
                      child: Text('Veri Güncelle'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';

class StatisticsPage extends StatefulWidget {
  final List<Transaction> transactions;

  StatisticsPage({required this.transactions});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedPeriod = 'Daily';
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = fetchTransactions();
  }

  // Verileri Firestore'dan çekme fonksiyonu
  Future<List<Transaction>> fetchTransactions() async {
    List<Transaction> transactions = [];
    try {
      var snapshot = await fs.FirebaseFirestore.instance
          .collection('transactions')
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        transactions.add(Transaction(
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as fs.Timestamp).toDate(),
          type: data['type'] ?? '',
          category: data['type_two'] ?? 'Uncategorized', // 'type_two' kategori olarak kullanılıyor
          sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
          type_two: data['type_two'] ?? '', // 'type_two' burada önemli
        ));
      }
    } catch (e) {
      print("Veri alınırken hata oluştu: $e");
    }
    return transactions;
  }

  // Veriyi sadece ekleme işlemi (eski verileri silmeden)
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

  List<Transaction> filterTransactionsByDate(
      List<Transaction> transactions, DateTime start, DateTime end) {
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }

  List<Transaction> getDailyTransactions(List<Transaction> transactions) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return filterTransactionsByDate(transactions, startOfDay, endOfDay);
  }

  List<Transaction> getWeeklyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));
    return filterTransactionsByDate(transactions, startOfWeek, endOfWeek);
  }

  List<Transaction> getMonthlyTransactions(List<Transaction> transactions) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);
    return filterTransactionsByDate(transactions, startOfMonth, endOfMonth);
  }

  double calculateIncome(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gelir')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateExpense(List<Transaction> transactions) {
    return transactions
        .where((transaction) => transaction.type == 'Gider')
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double calculateNet(List<Transaction> transactions) {
    return calculateIncome(transactions) - calculateExpense(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Veri bulunamadı.'));
          } else {
            List<Transaction> transactions = snapshot.data!;

            List<Transaction> transactionsToDisplay;
            String periodLabel;
            switch (selectedPeriod) {
              case 'Weekly':
                transactionsToDisplay = getWeeklyTransactions(transactions);
                periodLabel = 'Haftalık Veriler';
                break;
              case 'Monthly':
                transactionsToDisplay = getMonthlyTransactions(transactions);
                periodLabel = 'Aylık Veriler';
                break;
              default:
                transactionsToDisplay = getDailyTransactions(transactions);
                periodLabel = 'Günlük Veriler';
                break;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    periodLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Gelir: ${calculateIncome(transactionsToDisplay)}'),
                  Text('Gider: ${calculateExpense(transactionsToDisplay)}'),
                  SizedBox(height: 10),
                  Text(
                    'Net Durum: ${calculateNet(transactionsToDisplay)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Daily';
                          });
                        },
                        child: Text('Günlük'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Weekly';
                          });
                        },
                        child: Text('Haftalık'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPeriod = 'Monthly';
                          });
                        },
                        child: Text('Aylık'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => addTransactions(widget.transactions),
                      child: Text('Veri Güncelle'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
