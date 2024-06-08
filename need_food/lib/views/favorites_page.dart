import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/popular_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String searchQuery = '';

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Buscar'),
          content: TextField(
            onChanged: updateSearchQuery,
            decoration:
                const InputDecoration(hintText: 'Digite o nome do lanche'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Buscar'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> getUserFavoriteProductIds(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<dynamic> favoriteProducts = userDoc.get('favoriteProducts') ?? [];
    // Filtra IDs inválidos (e.g., strings vazias)
    return favoriteProducts
        .cast<String>()
        .where((id) => id.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
            const Text('Favoritos'),
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
              width: 40,
              height: 40,
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
                onPressed: _showSearchDialog,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? const Center(child: Text('Usuário não autenticado.'))
            : FutureBuilder<List<String>>(
                future: getUserFavoriteProductIds(user.uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var favoriteProductIds = snapshot.data!;
                  if (favoriteProductIds.isEmpty) {
                    return const Center(
                        child: Text('Nenhum produto encontrado.'));
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where(FieldPath.documentId,
                            whereIn: favoriteProductIds)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var favoriteItems = snapshot.data!.docs;

                      if (favoriteItems.isEmpty) {
                        return const Center(
                            child: Text('Nenhum produto encontrado.'));
                      }

                      var filteredItems = favoriteItems.where((product) {
                        var data = product.data() as Map<String, dynamic>;
                        return data['nome']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                      }).toList();

                      if (filteredItems.isEmpty) {
                        return const Center(
                            child: Text('Nenhum produto encontrado.'));
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: filteredItems.map((product) {
                            var data = product.data() as Map<String, dynamic>;

                            return GestureDetector(
                              onTap: () {},
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: SizedBox(
                                      width: 160,
                                      height: 200,
                                      child: PopularCard(
                                        productId: product.id,
                                        title: data['nome'],
                                        price: data['valor'],
                                        imageUrl: data['imageUrl'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
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
