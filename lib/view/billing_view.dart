import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:jwy/model/product.dart';
import 'package:jwy/utils/constants.dart';
import 'package:jwy/view/widgets/product_details_card.dart';
import 'package:jwy/view/widgets/reusable_button.dart';
import 'package:jwy/viewModel/billing_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jwy/services/billing_history_services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BillingView extends StatelessWidget {
  final Product product;
  const BillingView({super.key, required this.product});

  Future<Uint8List> _generatePdf(BillingViewModel billingViewModel) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Billing Receipt',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Product: ${product.name}'),
                pw.Text('Price: ₹${product.price}'),
                pw.Text('Discount: ${product.discount}%'),
                pw.Text('Tax: ${product.tax}%'),
                pw.Text('Quantity: ${billingViewModel.quantity}'),
                pw.Text('Total: ₹${billingViewModel.total.toStringAsFixed(2)}'),
                pw.SizedBox(height: 20),
                pw.Text('Date: ${DateTime.now().toString()}'),
              ],
            ),
      ),
    );
    return pdf.save();
  }

  void _showSuccessDialog(
    BuildContext context,
    BillingViewModel billingViewModel,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Billing completed successfully!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () async {
                  final pdf = await _generatePdf(billingViewModel);
                  await Printing.layoutPdf(onLayout: (_) => pdf);
                },
                child: const Text('Print Billing'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BillingViewModel>(
      create: (context) {
        final billingViewModel = BillingViewModel();
        billingViewModel.initialize(product);
        return billingViewModel;
      },

      child: Consumer<BillingViewModel>(
        builder: (context, billingViewModel, child) {
          final billingHistoryServices = BillingHistoryServices();

          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              title: const Text('Billing'),
              backgroundColor: kBackgroundColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProductDetailsCard(product: product),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity:', style: TextStyle(fontSize: 18)),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                onPressed:
                                    billingViewModel.quantity > 1
                                        ? () => billingViewModel
                                            .decreaseQuantity(product)
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                '${billingViewModel.quantity}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed:
                                    () => billingViewModel.increaseQuantity(
                                      product,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ReusableButton(
                      title:
                          'Total: ₹${billingViewModel.total.toStringAsFixed(2)}',
                      onPress: () async {
                        // Use getBillingRecord here
                        final billingRecord = billingViewModel.getBillingRecord(
                          product,
                        );
                        await billingHistoryServices.saveBilling(billingRecord);
                        _showSuccessDialog(context, billingViewModel);
                      },
                      color: const Color(0xFF6E42E5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
