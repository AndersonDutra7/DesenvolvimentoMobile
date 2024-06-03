import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:need_food/components/recommended_card.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recomendados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('products')
                .where('nome', whereIn: [
              'Especial da Casa Duas Pessoas',
              'X Bacon Aberto'
            ]).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var recommendedItems = snapshot.data!.docs;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: recommendedItems.map((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  return RecommendedCard(
                    title: data['nome'],
                    imageUrl: data['imageUrl'],
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
