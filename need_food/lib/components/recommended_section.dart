import 'package:flutter/material.dart';
import 'recommended_card.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recomendados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RecommendedCard(
                  title: 'Product A', imageUrl: 'assets/productA.jpg'),
              RecommendedCard(
                  title: 'Product B', imageUrl: 'assets/productB.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}
