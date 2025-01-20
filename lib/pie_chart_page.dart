/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatelessWidget {
  final Map<String, double> incomeData;
  final Map<String, double> expenseData;
  final String type;
  final List<String> categories;

  PieChartPage({
    required this.incomeData,
    required this.expenseData,
    required this.type,
    required this.categories,
  });

  List<Color> getCategoryColors() {
    return [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.yellow,
      Colors.teal,
      Colors.cyan,
      Colors.indigo,
      Colors.brown,
      Colors.lime,
      Colors.pink,
    ];
  }

  List<PieChartSectionData> _getChartData(Map<String, double> data) {
    double totalValue = data.values.fold(0, (sum, item) => sum + item);

    return data.entries.map((entry) {
      double percentage = (entry.value / totalValue) * 100;
      return PieChartSectionData(
        color: getCategoryColors()[data.keys.toList().indexOf(entry.key)],
        value: entry.value,
        title: "${percentage.toStringAsFixed(1)}%",
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataToDisplay = type == 'Gelir' ? incomeData : expenseData;

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Pasta grafiği
            Expanded(
              flex: 2,
              child: PieChart(
                PieChartData(
                  sections: _getChartData(dataToDisplay),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Kategoriler listesi
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: [
                      ...List.generate(categories.length, (index) {
                        String category = categories[index];
                        return Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: getCategoryColors()[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '$category: ${dataToDisplay[category]?.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatelessWidget {
  final Map<String, double> incomeData;
  final Map<String, double> expenseData;
  final String type;
  final List<String> categories;

  PieChartPage({
    required this.incomeData,
    required this.expenseData,
    required this.type,
    required this.categories,
  });

  List<Color> getCategoryColors() {
    return [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.yellow,
      Colors.teal,
      Colors.cyan,
      Colors.indigo,
      Colors.brown,
      Colors.lime,
      Colors.pink,
    ];
  }

  List<PieChartSectionData> _getChartData(Map<String, double> data) {
    double totalValue = data.values.fold(0, (sum, item) => sum + item);

    return data.entries.map((entry) {
      double percentage = (entry.value / totalValue) * 100;
      return PieChartSectionData(
        color: getCategoryColors()[data.keys.toList().indexOf(entry.key)],
        value: entry.value,
        title: "${percentage.toStringAsFixed(1)}%",
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataToDisplay = type == 'Gelir' ? incomeData : expenseData;

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Pasta grafiği
            Expanded(
              flex: 2,
              child: PieChart(
                PieChartData(
                  sections: _getChartData(dataToDisplay),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Kategoriler listesi
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: [
                      ...List.generate(categories.length, (index) {
                        String category = categories[index];
                        return Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: getCategoryColors()[index],
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '$category: ${dataToDisplay[category]?.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 */

/*
class PieChartPage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> incomeData;
  final Map<String, List<Map<String, dynamic>>> expenseData;
  final String type;
  final List<String> categories;

  PieChartPage({
    required this.incomeData,
    required this.expenseData,
    required this.type,
    required this.categories,
  });

  List<Color> getCategoryColors() {
    return [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.yellow,
      Colors.teal,
      Colors.cyan,
      Colors.indigo,
      Colors.brown,
      Colors.lime,
      Colors.pink,
    ];
  }

  List<PieChartSectionData> _getChartData(Map<String, List<Map<String, dynamic>>> data) {
    Map<String, double> aggregatedData = {};

    // Veriyi seçilen zaman dilimine göre grupla
    for (var category in categories) {
      aggregatedData[category] = 0.0;
      for (var transaction in data[category]!) {
        // İşlem tarihi al
        DateTime transactionDate = transaction['date'];
        DateTime now = DateTime.now();

        bool matchesTimePeriod = false;
        if (type == 'Günlük Özet' && transactionDate.day == now.day) {
          matchesTimePeriod = true;
        } else if (type == 'Haftalık Özet' && transactionDate.isAfter(now.subtract(Duration(days: now.weekday)))) {
          matchesTimePeriod = true;
        } else if (type == 'Aylık Özet' && transactionDate.month == now.month && transactionDate.year == now.year) {
          matchesTimePeriod = true;
        }

        if (matchesTimePeriod) {
          aggregatedData[category] = aggregatedData[category]! + transaction['amount'];
        }
      }
    }

    return aggregatedData.entries.map((entry) {
      return PieChartSectionData(
        color: getCategoryColors()[categories.indexOf(entry.key)],
        value: entry.value,
        title: "${entry.value.toStringAsFixed(1)}",
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> dataToDisplay = type == 'Gelir' ? incomeData : expenseData;

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PieChart(
                PieChartData(
                  sections: _getChartData(dataToDisplay),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'transaction.dart'; // Transaction modelini import ediyoruz

class PieChartPage extends StatelessWidget {
  final List<Transaction> transactions; // transactions parametresi
  final String type; // Gelir veya Gider tipi
  final List<String> categories; // Kategoriler

  PieChartPage({
    required this.transactions,
    required this.type,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // Gelir ve Gider işlemlerine göre işlem yapabiliriz
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    // İşlemleri analiz ediyoruz
    for (var transaction in transactions) {
      if (transaction.type == 'Gelir') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    // Grafik için render edilecek sayfa yapısı
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Toplam Gelir: $totalIncome'),
            Text('Toplam Gider: $totalExpense'),
            // Burada pasta grafik veya başka bir içerik gösterilebilir
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart'; // fl_chart paketini import ediyoruz

class PieChartPage extends StatelessWidget {
  final List<Transaction> transactions;
  final String type; // 'Gelir' veya 'Gider'
  final List<String> categories;

  PieChartPage({
    required this.transactions,
    required this.type,
    required this.categories,
  });

  // Kategori bazında toplam değerleri hesaplama
  Map<String, double> calculateCategoryTotals() {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction.type == type) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.amount;
      }
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = calculateCategoryTotals();
    final total = categoryTotals.values.fold(0.0, (sum, value) => sum + value);

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$type Toplamı: $total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: categoryTotals.isEmpty
                  ? Center(child: Text('Hiç $type verisi yok.'))
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
          ],
        ),
      ),
    );
  }

  // Kategorilere göre renkler
  Color _getCategoryColor(String category) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow
    ];
    int index = categories.indexOf(category);
    return colors[index % colors.length];
  }
}*/

/*
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart'; // fl_chart paketini import ediyoruz

class PieChartPage extends StatelessWidget {
  final List<Transaction> transactions;
  final String type; // 'Gelir' veya 'Gider'
  final List<String> categories;

  PieChartPage({
    required this.transactions,
    required this.type,
    required this.categories,
  });

  // Kategori bazında toplam değerleri hesaplama
  Map<String, double> calculateCategoryTotals() {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction.type == type) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.amount;
      }
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = calculateCategoryTotals();
    final total = categoryTotals.values.fold(0.0, (sum, value) => sum + value);

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Grafiği'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$type Toplamı: $total',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: categoryTotals.isEmpty
                  ? Center(child: Text('Hiç $type verisi yok.'))
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
            // Kategorilerin listesi
            categoryTotals.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategoriler:',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  // Kategorilere göre renkler
  Color _getCategoryColor(String category) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow
    ];
    int index = categories.indexOf(category);
    return colors[index % colors.length];
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart';


class PieChartPage extends StatefulWidget {
  final String type; // 'Gelir' veya 'Gider'

  PieChartPage({
    required this.type,


  });

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  late Future<List<Transaction>> transactionsFuture;
  List<String> categories = [];

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
          .where('type', isEqualTo: widget.type)
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
        if (!categories.contains(data['type_two'])) {
          categories.add(data['type_two'] ?? 'Uncategorized');
        }
      }
    } catch (e) {
      print("Veri alınırken hata oluştu: $e");
    }
    return transactions;
  }

  // Kategori bazında toplam değerleri hesaplama
  Map<String, double> calculateCategoryTotals(List<Transaction> transactions) {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
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
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Hiç ${widget.type} verisi yok.'));
          } else {
            List<Transaction> transactions = snapshot.data!;
            final categoryTotals = calculateCategoryTotals(transactions);
            final total =
            categoryTotals.values.fold(0.0, (sum, value) => sum + value);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '${widget.type} Toplamı: $total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: categoryTotals.isEmpty
                        ? Center(child: Text('Hiç ${widget.type} verisi yok.'))
                        : PieChart(
                      PieChartData(
                        sections: categoryTotals.entries.map((entry) {
                          final percentage =
                              (entry.value / total) * 100;
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
                  // Kategorilerin listesi
                  categoryTotals.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kategoriler:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ...categoryTotals.entries.map((entry) {
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
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

  // Kategorilere göre renkler
  Color _getCategoryColor(String category) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow
    ];
    int index = categories.indexOf(category);
    return colors[index % colors.length];
  }
}
*/
// pie_chart_page.dart

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  final String type;// 'Gelir' or 'Gider'
  final List<Transaction> transactions;//İşlem listesi
  final List<String> categories;//Kategori listesi


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
  List<String> categories = [];

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
          .where('type', isEqualTo: widget.type)
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
        if (!categories.contains(data['type_two'])) {
          categories.add(data['type_two'] ?? 'Uncategorized');
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return transactions;
  }

  Map<String, double> calculateCategoryTotals(List<Transaction> transactions) {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Chart'),
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
            final total =
            categoryTotals.values.fold(0.0, (sum, value) => sum + value);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '${widget.type} Total: $total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: categoryTotals.isEmpty
                        ? Center(child: Text('No ${widget.type} data available.'))
                        : PieChart(
                      PieChartData(
                        sections: categoryTotals.entries.map((entry) {
                          final percentage =
                              (entry.value / total) * 100;
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
                        'Categories:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ...categoryTotals.entries.map((entry) {
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
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
      Colors.yellow
    ];
    int index = categories.indexOf(category);
    return colors[index % colors.length];
  }
}

*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'transaction.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  final String type; // 'Gelir' or 'Gider'
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
  List<String> categories = [];

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
          .where('type', isEqualTo: widget.type)
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data();
        transactions.add(Transaction(
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          date: (data['date'] as fs.Timestamp).toDate(),
          type: data['type'] ?? '',
          category: data['type_two'] ?? 'Uncategorized', // type_two kategorisi
          sonuc: (data['sonuc'] as num?)?.toDouble() ?? 0.0,
          type_two: data['type_two'] ?? '', // type_two kategorisi
        ));

        // 'type_two' değerini kategoriler listesine ekle
        if (!categories.contains(data['type_two'])) {
          categories.add(data['type_two'] ?? 'Uncategorized');
        }
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
    return transactions;
  }

  Map<String, double> calculateCategoryTotals(List<Transaction> transactions) {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Chart'),
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
            final total =
            categoryTotals.values.fold(0.0, (sum, value) => sum + value);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '${widget.type} Total: $total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: categoryTotals.isEmpty
                        ? Center(child: Text('No ${widget.type} data available.'))
                        : PieChart(
                      PieChartData(
                        sections: categoryTotals.entries.map((entry) {
                          final percentage =
                              (entry.value / total) * 100;
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
                        'Categories:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
      Colors.yellow
    ];
    int index = categories.indexOf(category);
    return colors[index % colors.length];
  }
}


