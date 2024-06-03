import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;

  const ProductDetailPage({Key? key, required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: Center(
        child: Text('Detalhes do produto: $productName'),
      ),
    );
  }
}
