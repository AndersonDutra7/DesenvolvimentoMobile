import 'package:flutter/material.dart';

class CustomButtonAmbar extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;

  const CustomButtonAmbar({
    required this.onPressed,
    required this.text,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.amberAccent[700] ?? Colors.amberAccent;
              }
              return Colors.amberAccent[700] ?? Colors.amberAccent;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
