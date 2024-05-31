import 'package:flutter/material.dart';
import 'popular_card.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({Key? key}) : super(key: key); // Corrigindo o construtor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mais Populares',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return PopularCard(
                  title: 'Product ${index + 1}',
                  price: '\$${(index + 1) * 5}',
                  imageUrl: 'assets/product${index + 1}.jpg',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
