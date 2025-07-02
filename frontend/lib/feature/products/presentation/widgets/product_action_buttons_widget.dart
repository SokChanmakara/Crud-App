import 'package:flutter/material.dart';

class ProductActionButtonsWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String? saveButtonText;
  final String? cancelButtonText;
  final Color? saveButtonColor;

  const ProductActionButtonsWidget({
    super.key,
    required this.isLoading,
    required this.onSave,
    required this.onCancel,
    this.saveButtonText = 'Save',
    this.cancelButtonText = 'Cancel',
    this.saveButtonColor = const Color.fromARGB(255, 40, 173, 93),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: saveButtonColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child:
              isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : Text(saveButtonText!),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: isLoading ? null : onCancel,
          child: Text(cancelButtonText!),
        ),
      ],
    );
  }
}
