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
        backgroundColor: const Color(0xFF8B4513),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image.asset(
            'lib/assets/logo.png',
            height: 50,
          ),
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
                  offset:
                      const Offset(0, -1), // Mover o ícone 1 pixel para cima
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Cor de fundo branca
            ),
          ),
          const SingleChildScrollView(
            child: Column(
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
            child: const Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 50, 48, 48),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
