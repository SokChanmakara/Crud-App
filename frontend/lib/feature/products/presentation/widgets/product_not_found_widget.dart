import 'package:flutter/material.dart';

class ProductNotFoundWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;

  const ProductNotFoundWidget({
    super.key,
    this.title = 'Product Not Found',
    this.message = 'The product you\'re looking for doesn\'t exist.',
    this.icon = Icons.error_outline,
    this.iconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon!, size: 64, color: iconColor),
          const SizedBox(height: 16),
          Text(
            title!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message!,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
