import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onFavoritesPressed;
  final VoidCallback onMessagePressed;
  final VoidCallback onContactPressed;

  const CustomBottomNavBar({
    Key? key,
    required this.onHomePressed,
    required this.onFavoritesPressed,
    required this.onMessagePressed,
    required this.onContactPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            color: const Color.fromARGB(255, 50, 48, 48),
            onPressed: onHomePressed,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            color: const Color.fromARGB(255, 50, 48, 48),
            onPressed: onFavoritesPressed,
          ),
          const SizedBox(width: 40), // The dummy child
          IconButton(
            icon: const Icon(Icons.message),
            color: const Color.fromARGB(255, 50, 48, 48),
            onPressed: onMessagePressed,
          ),
          IconButton(
            icon: const Icon(Icons.contact_page),
            color: const Color.fromARGB(255, 50, 48, 48),
            onPressed: onContactPressed,
          ),
        ],
      ),
    );
  }
}
