import 'package:flutter/material.dart';

class ProductFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final String? nameLabel;
  final String? priceLabel;
  final String? stockLabel;

  const ProductFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.stockController,
    this.nameLabel = 'Product Name',
    this.priceLabel = 'Price (\$)',
    this.stockLabel = 'Stock Quantity',
  });

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: widget.nameLabel,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a product name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.priceController,
            decoration: InputDecoration(
              labelText: widget.priceLabel,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              if (double.parse(value) <= 0) {
                return 'Price must be positive';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.stockController,
            decoration: InputDecoration(
              labelText: widget.stockLabel,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter stock quantity';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              if (int.parse(value) < 0) {
                return 'Stock cannot be negative';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
