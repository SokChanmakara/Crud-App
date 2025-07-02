import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/presentation/providers/product_list_provider.dart';
import 'package:frontend/feature/products/presentation/widgets/product_form_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/product_action_buttons_widget.dart';

class EditProductPage extends ConsumerStatefulWidget {
  final String productId;

  const EditProductPage({super.key, required this.productId});

  @override
  ConsumerState<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  bool _isLoading = false;
  ProductEntity? _product;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with empty values first
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();

    // Load product data after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProductData();
    });
  }

  void _loadProductData() {
    final productState = ref.read(productListProvider);
    try {
      _product = productState.products.firstWhere(
        (p) => p.id == widget.productId,
      );

      // Update controllers with real data
      _nameController.text = _product?.name ?? '';
      _priceController.text = _product?.price.toString() ?? '';
      _stockController.text = _product?.stock.toString() ?? '';
    } catch (e) {
      // Product not found, keep empty controllers
      print('Product not found: ${widget.productId}');
    }
  }

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
      appBar: AppBar(title: const Text('Edit Product'), centerTitle: true),
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
              onSave: _updateProduct,
              onCancel: () => context.pop(),
              saveButtonText: 'Update Product',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate() && _product != null) {
      setState(() => _isLoading = true);

      final updatedProduct = _product!.copyWith(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text).toInt(),
        stock: int.parse(_stockController.text),
      );

      final success = await ref
          .read(productListProvider.notifier)
          .updateProduct(updatedProduct);

      setState(() => _isLoading = false);

      if (success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully')),
          );
          context.pop(); // Go back to previous page
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update product'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
