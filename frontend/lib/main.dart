import 'package:flutter/material.dart';
import 'package:frontend/feature/products/presentation/pages/product_list_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPage()
    );
  }
}