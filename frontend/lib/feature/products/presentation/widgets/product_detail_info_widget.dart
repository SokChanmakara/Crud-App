import 'package:flutter/material.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';

class ProductDetailInfoWidget extends StatelessWidget {
  final ProductEntity product;
  final String? description;

  const ProductDetailInfoWidget({
    super.key,
    required this.product,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image Placeholder
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.headphones, size: 80, color: Colors.grey),
        ),
        const SizedBox(height: 24),

        // Product Name
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Product Price
        Text(
          '\$${product.price}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.green[700],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Stock Information
        Text(
          'Stock: ${product.stock} units',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),

        if (description != null) ...[
          const SizedBox(height: 24),
          const Text(
            'Description:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(description!, style: const TextStyle(fontSize: 16)),
        ],
      ],
    );
  }
}
