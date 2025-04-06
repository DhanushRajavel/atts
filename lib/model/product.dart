import 'package:jwy/utils/constants.dart';

class Product {
  final String name;
  final double price;
  final String category;
  final double discount;
  final double tax;
  final String imageUrl = kImageUrl;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.discount,
    required this.tax,
  });

  // Convert Product object to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'category': category,
    'discount': discount,
    'tax': tax,
  };

  // Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json['name'],
    price: json['price'],
    category: json['category'],
    discount: json['discount'],
    tax: json['tax'],
  );
}
