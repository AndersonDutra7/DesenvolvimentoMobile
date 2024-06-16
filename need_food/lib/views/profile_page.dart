import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';
import 'package:need_food/views/orders_page.dart';
import 'package:need_food/views/favorites_page.dart';
import 'package:need_food/views/feedback_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = userDoc.data();
      if (data != null) {
        _nameController.text = data['username'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _addressController.text = data['address'] ?? '';
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'username': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      });
      setState(() {
        _isEditing = false;
      });
      _showSuccessDialog();
    }
  }

  Future<void> _showSuccessDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sucesso"),
          content: const Text("Perfil atualizado com sucesso!"),
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

  void _enableEditing() {
    setState(() {
      _isEditing = true;
    });
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
            const Text('Perfil'),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    enabled: _isEditing,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    enabled:
                        false, // Definindo como false para desabilitar a edição
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    enabled: _isEditing,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Endereço'),
                    enabled: _isEditing,
                  ),
                  const SizedBox(height: 16),
                  _isEditing
                      ? ElevatedButton(
                          onPressed: _updateUserProfile,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.amberAccent[700],
                          ),
                          child: const Text('Salvar'),
                        )
                      : ElevatedButton(
                          onPressed: _enableEditing,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.amberAccent[700],
                          ),
                          child: const Text('Editar Perfil'),
                        ),
                ],
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
}
