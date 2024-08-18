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
            _buildIconButton(
              icon: Icons.home,
              label: 'Home',
              onPressed: onHomeTap,
            ),
            _buildIconButton(
              icon: Icons.favorite,
              label: 'Favoritos',
              onPressed: onFavoritesTap,
            ),
            const Spacer(),
            _buildIconButton(
              icon: Icons.message,
              label: 'Feedbacks',
              onPressed: onFeedbackTap,
            ),
            _buildIconButton(
              icon: Icons.person,
              label: 'Profile',
              onPressed: onProfileTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(
              label,
              style: const TextStyle(fontSize: 8),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
