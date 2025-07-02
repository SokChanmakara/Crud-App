import 'package:flutter/material.dart';

class LoadingStateWidget extends StatelessWidget {
  final String? message;
  final double? progressSize;

  const LoadingStateWidget({
    super.key,
    this.message = 'Loading...',
    this.progressSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: progressSize,
            height: progressSize,
            child: const CircularProgressIndicator(),
          ),
          const SizedBox(height: 16),
          Text(message!, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class LoadingSnackBar {
  static void show({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
