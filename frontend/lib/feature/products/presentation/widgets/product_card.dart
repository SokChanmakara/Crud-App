import 'package:flutter/material.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});
  @override
  Widget build(BuildContext context) {
    final product = ProductEntity(
      name: 'Airpod',
      price: 120,
      imagePath: 'assets/images/airpod.jpeg',
      stock: 20,
    );
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              image: DecorationImage(
                image: AssetImage(product.imagePath ?? 'assets/images'),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  debugPrint('Error loading image: $exception');
                },
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4.0,),
                Text(
                  'Stock: ${product.stock}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.lightBlue,),
                SizedBox(width: 8,),
                Icon(Icons.delete, color: Colors.red)
              ],
            ),
          )
        ],
      ),
    );
  }
}
