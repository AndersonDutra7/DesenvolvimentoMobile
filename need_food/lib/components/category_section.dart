import 'package:flutter/material.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryCard(title: 'Burguer', imageUrl: 'assets/burguer.jpg'),
              CategoryCard(title: 'Drink', imageUrl: 'assets/drink.jpg'),
              CategoryCard(title: 'Pizza', imageUrl: 'assets/pizza.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}
