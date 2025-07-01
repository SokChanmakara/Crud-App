import 'package:flutter/material.dart';
import 'package:frontend/feature/products/presentation/widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.clear_all_rounded, size: 32,),
          )
        ],
      ),
      body: Container(
        child: ProductCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: const Color(0xFF94e0b2),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        ),
                
    );
  }
}
