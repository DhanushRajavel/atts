import 'package:flutter/material.dart';
import 'package:jwy/viewmodel/billing_view_model.dart';
import 'package:jwy/viewmodel/product_view_model.dart';
import 'package:jwy/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jwy/view/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => BillingViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    ),
  );
}