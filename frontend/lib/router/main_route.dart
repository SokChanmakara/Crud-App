import 'package:go_router/go_router.dart';
import 'package:frontend/feature/products/presentation/pages/product_list_page.dart';
import 'package:frontend/feature/products/presentation/pages/product_detail.dart';
import 'package:frontend/feature/products/presentation/pages/add_product_page.dart';
import 'package:frontend/feature/products/presentation/pages/edit_product_page.dart';
import 'package:frontend/core/errors/error_page.dart';
import 'package:frontend/core/constants/route_paths.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: RoutePaths.home,
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
    routes: [
      // Home/Products List Route
      GoRoute(
        path: RoutePaths.home,
        name: 'home',
        builder: (context, state) => const ProductListPage(),
      ),

      // Products Route (alternative path to home)
      GoRoute(
        path: RoutePaths.products,
        name: 'products',
        builder: (context, state) => const ProductListPage(),
      ),

      // Product Details Route
      GoRoute(
        path: RoutePaths.productDetails,
        name: 'product-details',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailPage(productId: productId);
        },
      ),

      // Add Product Route
      GoRoute(
        path: RoutePaths.addProduct,
        name: 'add-product',
        builder: (context, state) => const AddProductPage(),
      ),

      // Edit Product Route
      GoRoute(
        path: RoutePaths.editProduct,
        name: 'edit-product',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return EditProductPage(productId: productId);
        },
      ),

      // 404 Error Route
      GoRoute(
        path: RoutePaths.notFound,
        name: 'not-found',
        builder: (context, state) => const ErrorPage(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
