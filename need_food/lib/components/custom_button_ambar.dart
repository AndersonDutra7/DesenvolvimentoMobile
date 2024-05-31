import 'package:flutter/material.dart';

class CustomButtonAmbar extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  // final double width;

  const CustomButtonAmbar({
    required this.onPressed,
    required this.text,
    required this.height,
    // required this.width,
    Key? key, // Corrigindo o parâmetro key
  }) : super(key: key); // Passando a chave para o construtor da classe pai

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amberAccent[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
