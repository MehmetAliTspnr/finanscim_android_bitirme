/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  StatisticsPage({required this.transactions});

  List<Map<String, dynamic>> filterTransactionsByPeriod(String period) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'daily':
        startDate = now.subtract(Duration(days: 1));
        break;
      case 'weekly':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'monthly':
        startDate = DateTime(now.year, now.month).subtract(Duration(days: 1));
        break;
      default:
        startDate = now.subtract(Duration(days: 1)); // Default daily filter
    }

    return transactions.where((transaction) {
      DateTime transactionDate = DateTime.parse(transaction['date']);
      return transactionDate.isAfter(startDate);
    }).toList();
  }

  List<PieChartSectionData> getChartData(List<Map<String, dynamic>> filteredTransactions) {
    Map<String, double> categorySums = {};

    filteredTransactions.forEach((transaction) {
      double amount = transaction['amount'];
      String category = transaction['category'];
      if (categorySums.containsKey(category)) {
        categorySums[category] = categorySums[category]! + amount;
      } else {
        categorySums[category] = amount;
      }
    });

    return categorySums.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.blue,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Günlük İstatistikler'),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: getChartData(filterTransactionsByPeriod('daily')),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Haftalık İstatistikler'),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: getChartData(filterTransactionsByPeriod('weekly')),
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Aylık İstatistikler'),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: getChartData(filterTransactionsByPeriod('monthly')),
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

/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  StatisticsPage({required this.transactions});

  List<Map<String, dynamic>> filterTransactionsByPeriod(String period) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'daily':
        startDate = now.subtract(Duration(days: 1));
        break;
      case 'weekly':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'monthly':
        startDate = DateTime(now.year, now.month).subtract(Duration(days: 1));
        break;
      default:
        startDate = now.subtract(Duration(days: 1)); // Default daily filter
    }

    return transactions.where((transaction) {
      DateTime transactionDate = DateTime.parse(transaction['date']);
      return transactionDate.isAfter(startDate);
    }).toList();
  }

  List<PieChartSectionData> getChartData(List<Map<String, dynamic>> filteredTransactions) {
    Map<String, double> categorySums = {};

    filteredTransactions.forEach((transaction) {
      double amount = transaction['amount'];
      String category = transaction['category'];
      if (categorySums.containsKey(category)) {
        categorySums[category] = categorySums[category]! + amount;
      } else {
        categorySums[category] = amount;
      }
    });

    return categorySums.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.blue,
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
    return DefaultTabController(
      length: 3, // Günlük, Haftalık, Aylık için 3 sekme
      child: Scaffold(
        appBar: AppBar(
          title: Text('İstatistikler'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Günlük'),
              Tab(text: 'Haftalık'),
              Tab(text: 'Aylık'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Günlük Grafik
            Column(
              children: [
                Text('Günlük İstatistikler'),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: getChartData(filterTransactionsByPeriod('daily')),
                      centerSpaceRadius: 50,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
              ],
            ),
            // Haftalık Grafik
            Column(
              children: [
                Text('Haftalık İstatistikler'),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: getChartData(filterTransactionsByPeriod('weekly')),
                      centerSpaceRadius: 50,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
              ],
            ),
            // Aylık Grafik
            Column(
              children: [
                Text('Aylık İstatistikler'),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: getChartData(filterTransactionsByPeriod('monthly')),
                      centerSpaceRadius: 50,
                      sectionsSpace: 4,
                    ),
                  ),
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

class StatisticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  StatisticsPage({required this.transactions});

  // Verileri süreye göre filtreleme
  List<Map<String, dynamic>> filterTransactionsByPeriod(String period) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'daily':
        startDate = now.subtract(Duration(days: 1));
        break;
      case 'weekly':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'monthly':
        startDate = DateTime(now.year, now.month).subtract(Duration(days: 1));
        break;
      default:
        startDate = now.subtract(Duration(days: 1)); // Default daily filter
    }

    return transactions.where((transaction) {
      DateTime transactionDate = DateTime.parse(transaction['date']);
      return transactionDate.isAfter(startDate);
    }).toList();
  }

  // Gelir ve gider toplamlarını hesaplamak
  double calculateTotal(List<Map<String, dynamic>> filteredTransactions, String type) {
    double total = 0.0;
    for (var transaction in filteredTransactions) {
      if (transaction['type'] == type) {
        total += transaction['amount'];
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Günlük, Haftalık, Aylık için 3 sekme
      child: Scaffold(
        appBar: AppBar(
          title: Text('İstatistikler'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Günlük'),
              Tab(text: 'Haftalık'),
              Tab(text: 'Aylık'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Günlük Durum
            buildStatisticsBox('daily'),
            // Haftalık Durum
            buildStatisticsBox('weekly'),
            // Aylık Durum
            buildStatisticsBox('monthly'),
          ],
        ),
      ),
    );
  }

  // Verileri kutucuklar halinde göstermek için statik bir yapı
  Widget buildStatisticsBox(String period) {
    List<Map<String, dynamic>> filteredTransactions = filterTransactionsByPeriod(period);

    double totalIncome = calculateTotal(filteredTransactions, 'income');
    double totalExpense = calculateTotal(filteredTransactions, 'expense');
    double netAmount = totalIncome - totalExpense;

    String netStatus = netAmount >= 0 ? '$netAmount' : '($netAmount)'; // Negatifse parantez içinde göster
    Color netStatusColor = netAmount >= 0 ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            period == 'daily' ? 'Günlük Durum' : period == 'weekly' ? 'Haftalık Durum' : 'Aylık Durum',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 1)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Toplam Gelir:'),
                    Text('${totalIncome.toStringAsFixed(2)} ₺'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Toplam Gider:'),
                    Text('${totalExpense.toStringAsFixed(2)} ₺'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Net Durum:'),
                    Text(
                      netStatus,
                      style: TextStyle(color: netStatusColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'transaction.dart'; // Transaction modelini import ediyoruz

class StatisticsPage extends StatelessWidget {
  final List<Transaction> transactions; // transactions parametresi

  StatisticsPage({
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;
    double netAmount = 0.0;

    // İşlemleri analiz ediyoruz
    for (var transaction in transactions) {
      if (transaction.type == 'Gelir') {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    netAmount = totalIncome - totalExpense;

    // Grafik için render edilecek sayfa yapısı
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Toplam Gelir: $totalIncome'),
            Text('Toplam Gider: $totalExpense'),
            Text('Net Durum: ${netAmount < 0 ? '-' : ''} $netAmount'),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'transaction.dart'; // Transaction modelini import ediyoruz
import 'package:intl/intl.dart'; // Tarih formatı için

class StatisticsPage extends StatelessWidget {
  final List<Transaction> transactions;

  StatisticsPage({
    required this.transactions,
  });

  // Tarihleri filtreleme fonksiyonları
  List<Transaction> filterTransactionsByDate(DateTime start, DateTime end) {
    return transactions.where((transaction) {
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

  @override
  Widget build(BuildContext context) {
    // Günlük, haftalık ve aylık verileri alıyoruz
    List<Transaction> dailyTransactions = getDailyTransactions();
    List<Transaction> weeklyTransactions = getWeeklyTransactions();
    List<Transaction> monthlyTransactions = getMonthlyTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Günlük veriler
            Text(
              'Günlük Veriler: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Gelir: ${calculateIncome(dailyTransactions)}'),
            Text('Gider: ${calculateExpense(dailyTransactions)}'),
            SizedBox(height: 20),

            // Haftalık veriler
            Text(
              'Haftalık Veriler: ${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)))} - ${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)))}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Gelir: ${calculateIncome(weeklyTransactions)}'),
            Text('Gider: ${calculateExpense(weeklyTransactions)}'),
            SizedBox(height: 20),

            // Aylık veriler
            Text(
              'Aylık Veriler: ${DateFormat('yyyy-MM').format(DateTime.now())}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Gelir: ${calculateIncome(monthlyTransactions)}'),
            Text('Gider: ${calculateExpense(monthlyTransactions)}'),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
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


