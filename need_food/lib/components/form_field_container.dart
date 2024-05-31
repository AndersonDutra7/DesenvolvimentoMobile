import 'package:flutter/material.dart';
import 'package:need_food/components/custom_text_field.dart';

class FormFieldContainer extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const FormFieldContainer({
    Key? key, // Corrigindo o parâmetro key
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key); // Passando a chave para o construtor da classe pai

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: buttonWidth,
        child: CustomTextField(
          hintText: hintText,
          icon: icon,
          isPassword: isPassword,
        ),
      ),
    );
  }
}
