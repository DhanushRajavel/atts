import 'package:jwy/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductStorageServices {
  static const String _productKey = 'products';

  
  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonProducts =
        products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(_productKey, jsonProducts);
  }

  
  static Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonProducts = prefs.getStringList(_productKey);
    if (jsonProducts != null) {
      return jsonProducts
          .map((productJson) => Product.fromJson(jsonDecode(productJson)))
          .toList();
    }
    return [];
  }
}
