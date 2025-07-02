import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/presentation/providers/product_list_provider.dart';
import 'package:frontend/feature/products/presentation/widgets/product_detail_info_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/product_detail_actions_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/product_not_found_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:frontend/feature/products/presentation/widgets/loading_state_widget.dart';
import 'package:frontend/core/constants/route_paths.dart';

class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the product data from the provider
    final productState = ref.watch(productListProvider);

    // Find the product safely
    ProductEntity? foundProduct;
    try {
      foundProduct = productState.products.firstWhere((p) => p.id == productId);
    } catch (e) {
      // Product not found, will show not found UI
    }

    if (foundProduct == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Not Found'),
          centerTitle: true,
        ),
        body: const ProductNotFoundWidget(),
      );
    }

    return _buildProductDetail(context, ref, foundProduct);
  }

  Widget _buildProductDetail(
    BuildContext context,
    WidgetRef ref,
    ProductEntity product,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push(RoutePaths.editProductPath(productId));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProductDetailInfoWidget(
                product: product,
                description:
                    'High-quality wireless headphones with excellent sound quality and comfortable design. Perfect for music lovers and professionals.',
              ),
            ),
            ProductDetailActionsWidget(
              onEdit: () {
                context.push(RoutePaths.editProductPath(productId));
              },
              onDelete: () {
                _showDeleteDialog(context, ref, product);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    ProductEntity product,
  ) {
    DeleteConfirmationDialog.show(
      context: context,
      product: product,
      onConfirm: () async {
        // Show loading indicator
        if (context.mounted) {
          LoadingSnackBar.show(
            context: context,
            message: 'Deleting product...',
          );
        }

        // Call the delete function and await result
        final success = await ref
            .read(productListProvider.notifier)
            .deleteProduct(productId);

        if (context.mounted) {
          // Hide loading snackbar
          LoadingSnackBar.hide(context);

          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop(); // Return to product list
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to delete product'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }
}
