import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

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
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.favorite,
                  color: Color.fromARGB(255, 50, 48, 48)),
              onPressed: () {}),
          const SizedBox(width: 40), // The dummy child
          IconButton(
              icon: const Icon(Icons.message,
                  color: Color.fromARGB(255, 50, 48, 48)),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.contact_page,
                  color: Color.fromARGB(255, 50, 48, 48)),
              onPressed: () {}),
        ],
      ),
    );
  }
}
