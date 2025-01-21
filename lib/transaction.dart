/*class Transaction {
  DateTime date; // DateTime tipi tarih
  String type; // 'Gelir' veya 'Gider'
  double amount; // İşlem miktarı
  String category; // Kategori bilgisi
  double sonuc; // Sonuç bilgisi
  String type_two; // Kullanıcının seçtiği kategori

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
    required this.sonuc,
    required this.type_two, // Yeni alan (kullanıcının seçtiği kategori)
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']), // Firestore'dan gelen Timestamp, DateTime'a dönüştürülüyor
      type: json['type'] ?? 'Uncategorized', // 'type' alanı gelmezse varsayılan değer atanır
      amount: (json['amount'] as num).toDouble(), // Miktar, num'dan double'a dönüştürülüyor
      category: json['category'] ?? 'No category', // 'category' alanı gelmezse varsayılan değer atanır
      sonuc: (json['sonuc'] as num).toDouble(), // Sonuç bilgisi
      type_two: json['type_two'] ?? 'Uncategorized', // 'type_two' için varsayılan değer atanır
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
      'type_two': type_two, // Yeni alan (kullanıcının seçtiği kategori)
    };
  }
}*/

class Transaction {
  DateTime date; // DateTime tipi tarih
  String type; // 'Gelir' veya 'Gider'
  double amount; // İşlem miktarı
  String category; // Kategori bilgisi
  double sonuc; // Sonuç bilgisi
  String type_two; // Kullanıcının seçtiği kategori (category'nin kopyası)

  Transaction({
    required this.date,
    required this.type,
    required this.amount,
    required this.category,
    required this.sonuc,
    required this.type_two, // Yeni alan (kullanıcının seçtiği kategori)
  });

  // JSON'dan veri oluşturma
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: DateTime.parse(json['date']), // Firestore'dan gelen Timestamp, DateTime'a dönüştürülüyor
      type: json['type'] ?? 'Uncategorized', // 'type' alanı gelmezse varsayılan değer atanır
      amount: (json['amount'] as num).toDouble(), // Miktar, num'dan double'a dönüştürülüyor
      category: json['category'] ?? 'No category', // 'category' alanı gelmezse varsayılan değer atanır
      sonuc: (json['sonuc'] as num).toDouble(), // Sonuç bilgisi
      type_two: json['category'] ?? 'No category', // 'category' alanı type_two'ya aktarılıyor
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
      'type_two': category, // Burada 'type_two' olarak 'category' değerini gönderiyoruz
    };
  }
}


