import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  final String type; // Gelir veya Gider durumu
  final List<Transaction> transactions; // İşlem listesi
  final List<String> categories; // Kategori listesi

  PieChartPage({
    required this.type,
    required this.transactions,
    required this.categories,
  });

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late Future<List<Transaction>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = fetchTransactions();
  }

  Future<List<Transaction>> fetchTransactions() async {
    List<Transaction> transactions = [];
    try {
      var snapshot = await fs.FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date', descending: true) // Güncel tarih sıralı
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        transactions.add(Transaction(
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as fs.Timestamp).toDate(),
          type: data['type'] ?? '',
          category: data['category'] ?? 'No category',
          sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
          type_two: data['type_two'] ?? '', //Girilen kategori type_two
        ));
      }
    } catch (e) {
      print("Veri alınırken hata oluştu: $e");
    }
    return transactions;
  }

  // Kategorilere göre toplamları hesaplamak için
  Map<String, double> calculateCategoryTotals(List<Transaction> transactions) {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      // Yalnızca seçilen tipteki işlemleri ele al
      if (transaction.type == widget.type) {
        // 'type_two' burada kategori olarak kullanılıyor
        categoryTotals[transaction.type_two] = (categoryTotals[transaction.type_two] ?? 0) + transaction.amount;
      }
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Grafiği'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No ${widget.type} data available.'));
          } else {
            List<Transaction> transactions = snapshot.data!;
            final categoryTotals = calculateCategoryTotals(transactions);
            final total = categoryTotals.values.fold(0.0, (sum, value) => sum + value);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '${widget.type} Toplam: $total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: categoryTotals.isEmpty
                        ? Center(child: Text('No ${widget.type} data available.'))
                        : PieChart(
                      PieChartData(
                        sections: categoryTotals.entries.map((entry) {
                          final percentage = (entry.value / total) * 100;
                          return PieChartSectionData(
                            color: _getCategoryColor(entry.key),
                            value: percentage,
                            title: '${percentage.toStringAsFixed(1)}%',
                            radius: 100,
                            titleStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  categoryTotals.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kategoriler:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ...categoryTotals.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getCategoryColor(entry.key),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  )
                      : SizedBox(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow,
    ];
    int index = widget.categories.indexOf(category);
    return colors[index % colors.length];
  }
}


