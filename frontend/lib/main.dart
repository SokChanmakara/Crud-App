import 'package:flutter/material.dart';
import 'package:frontend/router/main_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Product CRUD App',
      routerConfig: AppRouter.router,
    );
  }
}
