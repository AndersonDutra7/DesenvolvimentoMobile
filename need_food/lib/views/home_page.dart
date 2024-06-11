import 'package:flutter/material.dart';
import 'package:need_food/components/banner_header.dart';
import 'package:need_food/components/category_section.dart';
import 'package:need_food/components/popular_section.dart';
import 'package:need_food/components/recommended_section.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';
import 'package:need_food/views/favorites_page.dart';
import 'package:need_food/views/feedback_page.dart';
import 'package:need_food/views/profile_page.dart';
import 'package:need_food/views/orders_page.dart';
import 'package:need_food/views/search_results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Buscar'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration:
                const InputDecoration(hintText: 'Digite o nome do lanche'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (searchQuery.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResultsPage(searchQuery: searchQuery),
                    ),
                  );
                }
              },
              child: const Text('Buscar'),
            ),
          ],
        );
      },
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void _navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrdersPage(),
      ),
    );
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoritesPage(),
      ),
    );
  }

  void _navigateToFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FeedbackPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'lib/assets/logo.png',
                height: 40,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Ralph & Teddy Lanches',
              style: TextStyle(fontSize: 18),
            ),
          ],
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
                onPressed: _showSearchDialog,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerHeader(),
                CategorySection(),
                PopularSection(),
                RecommendedSection(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToOrders,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.shopping_cart,
          color: Color.fromARGB(255, 50, 48, 48),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        onHomeTap: _scrollToTop,
        onFavoritesTap: _navigateToFavorites,
        onFeedbackTap: _navigateToFeedback,
        onProfileTap: _navigateToProfile,
      ),
    );
  }
}
