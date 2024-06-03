import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:need_food/components/popular_card.dart';

class CategoryPage extends StatelessWidget {
  final String categoryTitle;

  const CategoryPage({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryId;
    if (categoryTitle == 'Hambúrgueres') {
      categoryId = 'cat01';
    } else if (categoryTitle == 'Prensados') {
      categoryId = 'cat02';
    } else if (categoryTitle == 'Porções') {
      categoryId = 'cat03';
    } else {
      categoryId = '';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'lib/assets/logo.png',
                height: 40,
              ),
            ),
            const SizedBox(width: 8),
            Text(categoryTitle),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Transform.translate(
                  offset: const Offset(0, -1),
                  child: const Icon(
                    Icons.search,
                    color: Color(0xFF8B4513),
                  ),
                ),
                onPressed: () {
                  // Implementar funcionalidade de busca aqui
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('categoryId', isEqualTo: categoryId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var categoryItems = snapshot.data!.docs;

            if (categoryItems.isEmpty) {
              return const Center(child: Text('Nenhum produto encontrado.'));
            }

            return ListView.builder(
              itemCount: categoryItems.length,
              itemBuilder: (context, index) {
                var product = categoryItems[index];
                var data = product.data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: PopularCard(
                    title: data['nome'],
                    price: data['valor'],
                    imageUrl: data['imageUrl'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
