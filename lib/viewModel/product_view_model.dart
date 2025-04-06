import 'package:flutter/material.dart';
import 'package:jwy/model/product.dart';
import 'package:jwy/services/product_storage_services.dart';


class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductViewModel() {
    loadProducts();
  }

  
  Future<void> addProduct(Product product) async {
    _products.add(product);
    await ProductStorageServices.saveProducts(_products);
    notifyListeners();
  }

  
  Future<void> updateProduct(int index, Product updatedProduct) async {
    _products[index] = updatedProduct;
    await ProductStorageServices.saveProducts(_products);
    notifyListeners();
  }

  
  Future<void> deleteProduct(int index) async {
    _products.removeAt(index);
    await ProductStorageServices.saveProducts(_products);
    notifyListeners();
  }

  
  Future<void> loadProducts() async {
    _products = await ProductStorageServices.loadProducts();
    notifyListeners();
  }
}
