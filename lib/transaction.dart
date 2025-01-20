/*class Transaction {
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
}*/
/*
class Transaction {
  DateTime date; // DateTime tipi tarih
  String type; // 'Gelir' veya 'Gider'
  double amount; // İşlem miktarı
  String category; // Kategori bilgisi
  double sonuc; // Sonuç bilgisi
  String type_two; // Yeni alan

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
    required this.sonuc,
    required this.type_two, // Yeni alan
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']), // String'den DateTime'a dönüştürülüyor
      type: json['type'],
      amount: json['amount'],
      category: json['category'],
      sonuc: json['sonuc'], // Yeni alan JSON'dan alınıyor
      type_two: json['type_two'], // Yeni alan JSON'dan alınıyor
    );
  }

  // JSON formatına dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(), // DateTime'dan string'e dönüştürülüyor
      'type': type,
      'amount': amount,
      'category': category,
      'sonuc': sonuc, // Yeni alan JSON'a ekleniyor
      'type_two': type_two, // Yeni alan JSON'a ekleniyor
    };
  }
}
*/
class Transaction {
  DateTime date; // DateTime tipi tarih
  String type; // 'Gelir' veya 'Gider'
  double amount; // İşlem miktarı
  String category; // Kategori bilgisi
  double sonuc; // Sonuç bilgisi
  String type_two; // Yeni alan

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
    required this.sonuc,
    required this.type_two, // Yeni alan
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']), // Firestore'dan gelen Timestamp, DateTime'a dönüştürülüyor
      type: json['type'],
      amount: (json['amount'] as num).toDouble(), // Miktar, num'dan double'a dönüştürülüyor
      category: json['category'],
      sonuc: (json['sonuc'] as num).toDouble(), // Sonuç bilgisi
      type_two: json['type_two'] ?? 'Uncategorized', // Yeni alan, varsayılan değer veriliyor
    );
  }

  // JSON formatına dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'date': date, // DateTime, Firestore'a Timestamp olarak gönderilecek
      'type': type,
      'amount': amount,
      'category': category,
      'sonuc': sonuc, // Sonuç bilgisi
      'type_two': type_two, // Yeni alan
    };
  }
}
