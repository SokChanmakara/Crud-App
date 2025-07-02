import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/presentation/widgets/product_card.dart';
import 'package:frontend/feature/products/presentation/widgets/search_bar_widget.dart';
import 'package:frontend/feature/products/presentation/providers/product_list_provider.dart';
import 'package:frontend/feature/products/presentation/providers/product_state.dart';
import 'package:frontend/core/constants/route_paths.dart';

class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({super.key});

  @override
  ConsumerState<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  @override
  void initState() {
    super.initState();
    // Load products when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productListProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productListProvider);

    // Listen for errors and show snackbar
    ref.listen<ProductState>(productListProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed:
                  () => ref.read(productListProvider.notifier).clearError(),
            ),
          ),
        );
      }

      // Show success message when a product is deleted
      if (previous != null &&
          previous.products.length > next.products.length &&
          next.status == ProductStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product deleted successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                ref.read(productListProvider.notifier).loadProducts();
              },
              child: const Icon(Icons.refresh, size: 32),
            ),
          ),
        ],
      ),
      body: _buildBody(productState),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.addProduct);
        },
        backgroundColor: const Color.fromARGB(255, 40, 173, 93),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(ProductState state) {
    switch (state.status) {
      case ProductStatus.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading products...'),
            ],
          ),
        );

      case ProductStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.errorMessage}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed:
                    () => ref.read(productListProvider.notifier).loadProducts(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );

      case ProductStatus.success:
        if (state.products.isEmpty) {
          return RefreshIndicator(
            onRefresh:
                () => ref.read(productListProvider.notifier).loadProducts(),
            child: Column(
              children: [
                SearchBarWidget(
                  hintText: 'Search products by name...',
                  initialValue: state.searchQuery,
                  onChanged: (query) {
                    ref
                        .read(productListProvider.notifier)
                        .searchProducts(query);
                  },
                  onClear: () {
                    ref.read(productListProvider.notifier).clearSearch();
                  },
                ),
                Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 150), // Add some top spacing
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add your first product using the + button',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh:
              () => ref.read(productListProvider.notifier).loadProducts(),
          child: Column(
            children: [
              SearchBarWidget(
                hintText: 'Search products by name...',
                initialValue: state.searchQuery,
                onChanged: (query) {
                  ref.read(productListProvider.notifier).searchProducts(query);
                },
                onClear: () {
                  ref.read(productListProvider.notifier).clearSearch();
                },
              ),
              Expanded(
                child:
                    state.filteredProducts.isEmpty &&
                            state.searchQuery.isNotEmpty
                        ? _buildNoSearchResults()
                        : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: state.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = state.filteredProducts[index];
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

      default:
        return RefreshIndicator(
          onRefresh:
              () => ref.read(productListProvider.notifier).loadProducts(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 200), // Add some top spacing
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text('Welcome to Product Manager'),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildNoSearchResults() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search terms',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
