/*class Transaction {
  String date;
  String type;  // 'income' veya 'expense'
  double amount;
  String category;

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'],
      type: json['type'],
      amount: json['amount'],
      category: json['category'],
    );
  }

  // JSON formatına dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'type': type,
      'amount': amount,
      'category': category,
    };
  }
}
*/

class Transaction {
  DateTime date; // DateTime tipi tarih
  String type;  // 'Gelir' veya 'Gider'
  double amount;
  String category;

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']),  // String'den DateTime'a dönüştürülüyor
      type: json['type'],
      amount: json['amount'],
      category: json['category'],
    );
  }

  // JSON formatına dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),  // DateTime'dan string'e dönüştürülüyor
      'type': type,
      'amount': amount,
      'category': category,
    };
  }
}
