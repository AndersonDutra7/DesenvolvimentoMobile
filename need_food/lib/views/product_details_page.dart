import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';
import 'package:need_food/views/favorites_page.dart';
import 'package:need_food/views/feedback_page.dart';
import 'package:need_food/views/profile_page.dart';
import 'package:need_food/views/orders_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final favoriteProducts = userData.get('favoriteProducts') ?? [];
      setState(() {
        isFavorite = favoriteProducts.contains(widget.productId);
      });
    }
  }

  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    var favoriteProducts = userData.get('favoriteProducts') ?? [];
    if (favoriteProducts.contains(widget.productId)) {
      favoriteProducts.remove(widget.productId);
    } else {
      favoriteProducts.add(widget.productId);
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'favoriteProducts': favoriteProducts});
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> addToCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final productDocRef = FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId);

      final productDoc = await productDocRef.get();
      if (productDoc.exists) {
        final productData = productDoc.data() as Map<String, dynamic>;

        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        final userDoc = await userDocRef.get();
        if (userDoc.exists) {
          List<dynamic> cart = userDoc.data()?['cart'] ?? [];

          bool productExists = false;

          for (var item in cart) {
            if (item['productId'] == widget.productId) {
              item['quantity'] += 1;
              productExists = true;
              break;
            }
          }

          if (!productExists) {
            cart.add({
              'productId': widget.productId,
              'productName': productData['nome'],
              'productPrice': productData['valor'],
              'productImageUrl': productData['imageUrl'],
              'quantity': 1,
            });
          }

          await userDocRef.update({'cart': cart});

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sucesso"),
                content: const Text("Produto adicionado ao carrinho"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  Future<DocumentSnapshot> getProductDetails() async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset('lib/assets/logo.png', height: 40),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Ralph & Teddy Lanches',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () async {
              await toggleFavorite();
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Produto não encontrado'));
          }

          var productData = snapshot.data!.data() as Map<String, dynamic>;
          var productName = productData['nome'] ?? '';
          var productPrice = productData['valor'] ?? '';
          var productImageUrl = productData['imageUrl'] ?? '';
          var productDescription = productData['descricao'] ?? '';
          var productRating = productData['avaliacao']?.toDouble() ?? 4.7;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      productImageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            productPrice,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 4),
                          Text(
                            productRating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Descrição:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        productDescription,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text(
                        'Feedback',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: addToCart,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text(
                        'Pedido',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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
}
