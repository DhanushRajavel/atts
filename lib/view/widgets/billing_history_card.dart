import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwy/model/billing_record.dart';
import 'package:jwy/utils/constants.dart';

class BillingHistoryCard extends StatelessWidget {
  const BillingHistoryCard({super.key , required this.record});
  final BillingRecord record;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Image.network(kImageUrl, height: 75, width: 75),
        title: Text(
          record.productName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${record.quantity}'),
            Text('Total: ₹${record.total.toStringAsFixed(2)}'),
            Text('Date: ${record.date.toString()}'),
          ],
        ),
      ),
    );
  }
}
