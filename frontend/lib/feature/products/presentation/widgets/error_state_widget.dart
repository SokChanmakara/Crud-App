import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? title;
  final String errorMessage;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final Color? iconColor;

  const ErrorStateWidget({
    super.key,
    this.title = 'Error',
    required this.errorMessage,
    this.onRetry,
    this.retryButtonText = 'Retry',
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
            '$title: $errorMessage',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: Text(retryButtonText!)),
          ],
        ],
      ),
    );
  }
}
