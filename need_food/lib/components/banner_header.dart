import 'package:flutter/material.dart';

class BannerHeader extends StatelessWidget {
  const BannerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B4513).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 50,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(
            'lib/assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
