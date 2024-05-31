import 'package:flutter/material.dart';

class BannerHeader extends StatelessWidget {
  const BannerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.blueAccent,
      child: const Center(
        child: Text(
          'Welcome to NeedFood!',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
