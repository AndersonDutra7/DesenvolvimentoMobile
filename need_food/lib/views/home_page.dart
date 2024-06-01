import 'package:flutter/material.dart';
import 'package:need_food/components/banner_header.dart';
import 'package:need_food/components/category_section.dart';
import 'package:need_food/components/popular_section.dart';
import 'package:need_food/components/recommended_section.dart';
import 'package:need_food/components/custom_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeedFood'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF8B4513), // Cor de fundo marrom
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/logo_small.png', // Caminho da imagem do logo
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const CategorySection(),
                const PopularSection(),
                const RecommendedSection(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 28.0),
          child: FloatingActionButton(
            onPressed: () {
              // Navegar para a página do carrinho
            },
            backgroundColor: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  28.0), // Isso garante que ele seja redondo
            ),
            child: const Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 50, 48, 48)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
