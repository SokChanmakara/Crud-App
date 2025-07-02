import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/presentation/widgets/product_card.dart';
import 'package:frontend/core/constants/route_paths.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // You can add functionality for clear all here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clear all functionality')),
                );
              },
              child: const Icon(Icons.clear_all_rounded, size: 32),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCard(
            productId: (index + 1).toString(), 
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.addProduct);
        },
        backgroundColor: const Color(0xFF94e0b2),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
