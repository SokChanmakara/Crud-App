import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/feature/products/domain/entities/product_entity.dart';
import 'package:frontend/feature/products/presentation/widgets/product_card.dart';
import 'package:frontend/feature/products/presentation/widgets/search_bar_widget.dart';
import 'package:frontend/feature/products/presentation/widgets/empty_state_widget.dart';
import 'package:frontend/feature/products/presentation/providers/product_list_provider.dart';

class ProductListContentWidget extends ConsumerWidget {
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String searchQuery;
  final Future<void> Function() onRefresh;

  const ProductListContentWidget({
    super.key,
    required this.products,
    required this.filteredProducts,
    required this.searchQuery,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (products.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: Column(
          children: [
            SearchBarWidget(
              hintText: 'Search products by name...',
              initialValue: searchQuery,
              onChanged: (query) {
                ref.read(productListProvider.notifier).searchProducts(query);
              },
              onClear: () {
                ref.read(productListProvider.notifier).clearSearch();
              },
            ),
            const Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: EmptyStateWidget(
                    title: 'No products found',
                    message: 'Add your first product using the + button',
                    icon: Icons.inventory_2_outlined,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: [
          SearchBarWidget(
            hintText: 'Search products by name...',
            initialValue: searchQuery,
            onChanged: (query) {
              ref.read(productListProvider.notifier).searchProducts(query);
            },
            onClear: () {
              ref.read(productListProvider.notifier).clearSearch();
            },
          ),
          Expanded(
            child:
                filteredProducts.isEmpty && searchQuery.isNotEmpty
                    ? const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 400,
                        child: EmptyStateWidget(
                          title: 'No products found',
                          message: 'Try adjusting your search terms',
                          icon: Icons.search_off,
                        ),
                      ),
                    )
                    : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(
                          product: product,
                          productId: product.id ?? '',
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
