class RoutePaths {
  // Root routes
  static const String home = '/';
  static const String products = '/products';

  // Product routes
  static const String productDetails = '/product/:id';
  static const String addProduct = '/add-product';
  static const String editProduct = '/edit-product/:id';

  // Error routes
  static const String notFound = '/404';

  // Helper methods for dynamic routes
  static String productDetailsPath(String id) => '/product/$id';
  static String editProductPath(String id) => '/edit-product/$id';
}
