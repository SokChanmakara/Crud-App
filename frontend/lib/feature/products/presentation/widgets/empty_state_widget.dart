import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    this.title = 'No items found',
    this.message = 'There are no items to display.',
    this.icon = Icons.inventory_2_outlined,
    this.iconColor = Colors.grey,
    this.action,
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
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            message!,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    );
  }
}
