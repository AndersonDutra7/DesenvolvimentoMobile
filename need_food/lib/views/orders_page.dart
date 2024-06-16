import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';
import 'package:need_food/views/favorites_page.dart';
import 'package:need_food/views/feedback_page.dart';
import 'package:need_food/views/profile_page.dart';
import 'package:need_food/components/product_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    calculateTotalAmount();
  }

  Future<void> calculateTotalAmount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final cart = userDoc.data()?['cart'] ?? [];

        double total = 0.0;
        for (var item in cart) {
          final productPrice = double.parse((item['productPrice'] as String)
              .replaceAll('R\$ ', '')
              .replaceAll(',', '.'));
          final quantity = item['quantity'] as int;
          total += productPrice * quantity;
        }

        setState(() {
          totalAmount = total;
        });
      } catch (e) {
        print('Erro ao calcular o total: $e');
      }
    }
  }

  Future<void> updateCart(String productId, int delta) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userDoc = await userDocRef.get();

        List<dynamic> cart = userDoc.data()?['cart'] ?? [];

        for (var item in cart) {
          if (item is Map<String, dynamic> && item['productId'] == productId) {
            item['quantity'] += delta;
            if (item['quantity'] <= 0) {
              cart.remove(item);
            }
            break;
          }
        }

        await userDocRef.update({'cart': cart});
        calculateTotalAmount();
      } catch (e) {
        print('Erro ao atualizar o carrinho: $e');
      }
    }
  }

  Future<void> finalizeOrder() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userDoc = await userDocRef.get();
        final cart = userDoc.data()?['cart'] ?? [];

        if (cart.isNotEmpty) {
          await FirebaseFirestore.instance.collection('orders').add({
            'userId': user.uid,
            'userName': user.displayName ?? '',
            'userEmail': user.email ?? '',
            'timestamp': DateTime.now(),
            'products': cart,
            'totalAmount': totalAmount,
          });

          await userDocRef.update({'cart': []});
          setState(() {
            totalAmount = 0.0;
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sucesso"),
                content: const Text("Pedido finalizado com sucesso!"),
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
      } catch (e) {
        print('Erro ao finalizar o pedido: $e');
      }
    }
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
            const Text('Pedidos'),
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar o carrinho: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data?['cart'] == null ||
              (snapshot.data!['cart'] as List).isEmpty) {
            return const Center(child: Text('Seu carrinho está vazio'));
          }

          final cart = snapshot.data!['cart'] as List<dynamic>;
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: cart.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final item = cart[index] as Map<String, dynamic>;
                    return ProductCard(
                      productId: item['productId'],
                      productName: item['productName'] ?? '',
                      productPrice: item['productPrice'] ?? '',
                      productImageUrl: item['productImageUrl'] ??
                          'lib/assets/placeholder.png',
                      quantity: item['quantity'] ?? 0,
                      onAdd: () => updateCart(item['productId'], 1),
                      onRemove: () => updateCart(item['productId'], -1),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: R\$ ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: finalizeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent[700],
                      ),
                      child: const Text('Finalizar Pedido',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
