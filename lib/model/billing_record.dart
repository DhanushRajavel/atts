class BillingRecord {
  final String productName;
  final double price;
  final double discount;
  final double tax;
  final int quantity;
  final double total;
  final DateTime date;

  BillingRecord({
    required this.productName,
    required this.price,
    required this.discount,
    required this.tax,
    required this.quantity,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'price': price,
        'discount': discount,
        'tax': tax,
        'quantity': quantity,
        'total': total,
        'date': date.toIso8601String(),
      };

  factory BillingRecord.fromJson(Map<String, dynamic> json) => BillingRecord(
        productName: json['productName'] as String,
        price: (json['price'] as num).toDouble(),
        discount: (json['discount'] as num).toDouble(),
        tax: (json['tax'] as num).toDouble(),
        quantity: json['quantity'] as int,
        total: (json['total'] as num).toDouble(),
        date: DateTime.parse(json['date'] as String),
      );
}