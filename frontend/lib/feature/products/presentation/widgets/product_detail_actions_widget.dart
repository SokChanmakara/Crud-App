import 'package:flutter/material.dart';

class ProductDetailActionsWidget extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String? editButtonText;
  final String? deleteButtonText;

  const ProductDetailActionsWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.editButtonText = 'Edit Product',
    this.deleteButtonText = 'Delete Product',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 40, 173, 93),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(editButtonText!),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(deleteButtonText!),
          ),
        ),
      ],
    );
  }
}
