import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onFeedbackTap;
  final VoidCallback onProfileTap;

  const CustomBottomNavBar({
    Key? key,
    required this.onHomeTap,
    required this.onFavoritesTap,
    required this.onFeedbackTap,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: IconButton(
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home),
                    Text('Home', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: onHomeTap,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite),
                    Text('Favorites', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: onFavoritesTap,
              ),
            ),
            const Spacer(),
            Expanded(
              child: IconButton(
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message),
                    Text('Feedback', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: onFeedbackTap,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person),
                    Text('Profile', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: onProfileTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
