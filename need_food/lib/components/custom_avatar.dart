import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String imagePath;
  final double size;

  const CustomAvatar({
    Key? key,
    required this.imagePath,
    this.size = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
