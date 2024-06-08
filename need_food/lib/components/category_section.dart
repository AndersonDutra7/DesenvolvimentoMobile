import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var categories = snapshot.data!.docs;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center, // Alteração aqui
                children: [
                  for (var doc in categories)
                    CategoryCard(
                      title: (doc.data() as Map<String, dynamic>)['nome'],
                      imageUrl:
                          (doc.data() as Map<String, dynamic>)['imageUrl'],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
