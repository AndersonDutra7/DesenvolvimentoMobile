import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página da categoria
        print('Categoria $title clicada');
      },
      child: Container(
        width: 80,
        height: 100,
        margin: const EdgeInsets.symmetric(
            horizontal: 8.0), // Espaçamento horizontal entre os cards
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Usar NetworkImage para URLs
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
