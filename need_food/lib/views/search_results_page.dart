import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/popular_card.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';
import 'package:need_food/views/favorites_page.dart';
import 'package:need_food/views/feedback_page.dart';
import 'package:need_food/views/profile_page.dart';
import 'package:need_food/views/orders_page.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late String userId;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user != null ? user.uid : '';
    searchQuery = widget.searchQuery;
  }

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
                setState(() {
                  searchQuery = searchQuery;
                });
              },
              child: const Text('Buscar'),
            ),
          ],
        );
      },
    );
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _fetchSearchResults(searchQuery),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var results = snapshot.data!.docs;

            if (results.isEmpty) {
              return const Center(child: Text('Nenhum produto encontrado.'));
            }

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var product = results[index];
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
                          width: MediaQuery.of(context).size.width - 32,
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
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersPage()),
          );
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.shopping_cart,
          color: Color.fromARGB(255, 50, 48, 48),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        onHomeTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        onFavoritesTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoritesPage()),
          );
        },
        onFeedbackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackPage()),
          );
        },
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchSearchResults(String query) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('nome', isGreaterThanOrEqualTo: query)
        .where('nome', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots();
  }
}
