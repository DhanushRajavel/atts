import 'package:flutter/material.dart';
import 'package:jwy/model/product.dart';
import 'package:jwy/model/billing_record.dart';

class BillingViewModel extends ChangeNotifier {
  int _quantity = 1;
  double _total = 0;

  int get quantity => _quantity;
  double get total => _total;

  void initialize(Product product) {
    _calculateTotal(product);
  }

  void increaseQuantity(Product product) {
    _quantity++;
    _calculateTotal(product);
  }

  void decreaseQuantity(Product product) {
    if (_quantity > 1) {
      _quantity--;
      _calculateTotal(product);
    }
  }

  void _calculateTotal(Product product) {
    double price = product.price * _quantity;
    double discountAmount = price * (product.discount / 100);
    double taxAmount = (price - discountAmount) * (product.tax / 100);
    _total = price - discountAmount + taxAmount;
    notifyListeners();
  }

  BillingRecord getBillingRecord(Product product) {
    return BillingRecord(
      productName: product.name,
      price: product.price,
      discount: product.discount,
      tax: product.tax,
      quantity: _quantity,
      total: _total,
      date: DateTime.now(),
    );
  }
}
