import 'package:flutter/material.dart';

class RecommendedCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const RecommendedCard({
    Key? key, // Corrigindo o parâmetro key
    required this.title,
    required this.imageUrl,
  }) : super(key: key); // Passando a chave para o construtor da classe pai

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página do produto
        print('Produto $title clicado');
      },
      child: Container(
        width: 160,
        height: 100,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
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
