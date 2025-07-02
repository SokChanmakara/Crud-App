import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/presentation/providers/product_list_provider.dart';
import 'package:frontend/feature/products/presentation/widgets/product_form_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/product_action_buttons_widget.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ProductFormWidget(
                formKey: _formKey,
                nameController: _nameController,
                priceController: _priceController,
                stockController: _stockController,
              ),
            ),
            ProductActionButtonsWidget(
              isLoading: _isLoading,
              onSave: _saveProduct,
              onCancel: () => context.pop(),
              saveButtonText: 'Add Product',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final product = ProductEntity(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text).toInt(),
        stock: int.parse(_stockController.text),
      );

      final success = await ref
          .read(productListProvider.notifier)
          .addProduct(product);

      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        context.pop(); // Go back to previous page
      } else {
        // Error handling is done through the provider listener in the product list page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add product'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
