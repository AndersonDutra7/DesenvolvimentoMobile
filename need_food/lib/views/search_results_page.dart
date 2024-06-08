import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/popular_card.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late String userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user != null ? user.uid : '';
  }

  @override
  Widget build(BuildContext context) {
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
            const Flexible(
              child: Text(
                'Ralph & Teddy Lanches',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchSearchResults(widget.searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          } else {
            final results = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: results.map((product) {
                  var data = product.data() as Map<String, dynamic>;

                  String productName = data['nome'] ?? 'Nome não disponível';
                  String productPrice = data['valor']?.toString() ?? '0.00';
                  String productImageUrl =
                      data['imageUrl'] ?? 'lib/assets/placeholder.png';

                  return GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: SizedBox(
                            width: 160,
                            height: 200,
                            child: PopularCard(
                              productId: product.id,
                              title: productName,
                              price: productPrice,
                              imageUrl: productImageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<QuerySnapshot> _fetchSearchResults(String query) async {
    return FirebaseFirestore.instance
        .collection('products')
        .where('nome', isGreaterThanOrEqualTo: query)
        .where('nome', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
  }
}
