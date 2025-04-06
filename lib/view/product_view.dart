import 'package:flutter/material.dart';
import 'package:jwy/model/product.dart';
import 'package:jwy/utils/constants.dart';
import 'package:jwy/view/billing_history_view.dart';
import 'package:jwy/view/billing_view.dart';
import 'package:jwy/view/login_view.dart';
import 'package:jwy/view/widgets/add_product_dialog.dart';
import 'package:jwy/view/widgets/product_card.dart';
import 'package:jwy/viewmodel/product_view_model.dart';
import 'package:jwy/viewmodel/login_view_model.dart'; // Add this import
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context); // Access LoginViewModel

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Jewelry App'),
        backgroundColor: kBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillingHistoryView(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.history),
                ),
                IconButton(
                  onPressed: () {
                    loginViewModel.logout(); // Call logout to update state
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products Management',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 800,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.54,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BillingView(
                            product: provider.products[index],
                          ),
                        ),
                      );
                    },
                    product: provider.products[index],
                    onDelete: () {
                      provider.deleteProduct(index);
                    },
                    onEdit: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddProductDialog(
                          product: provider.products[index],
                          onSubmit: (name, price, category, discount, tax) {
                            provider.updateProduct(
                              index,
                              Product(
                                name: name,
                                price: price,
                                category: category,
                                discount: discount,
                                tax: tax,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddProductDialog(
              onSubmit: (name, price, category, discount, tax) {
                provider.addProduct(
                  Product(
                    name: name,
                    price: price,
                    category: category,
                    discount: discount,
                    tax: tax,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}