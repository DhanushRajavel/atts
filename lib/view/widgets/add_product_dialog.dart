import 'package:flutter/material.dart';
import 'package:jwy/model/product.dart';

class AddProductDialog extends StatefulWidget {
  final Function(String, double, String, double, double) onSubmit;
  final Product? product; // Accepting product object

  const AddProductDialog({
    super.key,
    required this.onSubmit,
    this.product, // Optional product for editing
  });

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _taxController;
  String _selectedCategory = 'Gold';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _discountController = TextEditingController(text: widget.product?.discount.toString() ?? '');
    _taxController = TextEditingController(text: widget.product?.tax.toString() ?? '');
    _selectedCategory = widget.product?.category ?? 'Gold';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _nameController.text,
        double.parse(_priceController.text),
        _selectedCategory,
        double.parse(_discountController.text),
        double.parse(_taxController.text),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'Enter a name' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Enter a valid price' : null,
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['Gold', 'Silver', 'Diamond', 'Platinum']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            TextFormField(
              controller: _discountController,
              decoration: const InputDecoration(labelText: 'Discount (%)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _taxController,
              decoration: const InputDecoration(labelText: 'Tax (%)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
