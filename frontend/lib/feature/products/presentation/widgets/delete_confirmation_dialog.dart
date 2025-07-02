import 'package:flutter/material.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String? title;
  final String? confirmText;
  final String? cancelText;

  const DeleteConfirmationDialog({
    super.key,
    required this.product,
    required this.onConfirm,
    this.onCancel,
    this.title = 'Delete Product',
    this.confirmText = 'Delete',
    this.cancelText = 'Cancel',
  });

  static Future<void> show({
    required BuildContext context,
    required ProductEntity product,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String? title,
    String? confirmText,
    String? cancelText,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          product: product,
          onConfirm: onConfirm,
          onCancel: onCancel,
          title: title,
          confirmText: confirmText,
          cancelText: cancelText,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text('Are you sure you want to delete "${product.name}"?'),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(cancelText!),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text(confirmText!),
        ),
      ],
    );
  }
}
