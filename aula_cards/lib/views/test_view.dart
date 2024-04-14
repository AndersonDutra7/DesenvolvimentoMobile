import 'package:flutter/material.dart';
import 'package:aula_cards/views/detail_product.dart';

class TestView extends StatefulWidget {
  String title;

  TestView({super.key, required this.title});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailProduct(),
            //   ),
            // );

            Navigator.pop(context);
          },
          child: const Text('Voltar para detalhe'),
        ),
      ),
    );
  }
}
