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
