import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwy/model/product.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                product.name,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '₹ ${product.price}',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 22, color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Discount: ${product.discount}%',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            'Tax: ${product.tax}%',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          Text(
            'Note: The total price displayed here includes all applied discounts and taxes.',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
