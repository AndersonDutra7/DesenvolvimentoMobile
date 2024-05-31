import 'package:flutter/material.dart';
import 'package:need_food/components/custom_button_ambar.dart';
import 'package:need_food/components/custom_avatar.dart';
import 'package:need_food/components/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          const Color(0xFF8B4513), // Tom de marrom para o background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomAvatar(
                imagePath: 'lib/assets/logo.png',
                size: 150,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: buttonWidth,
                  child: const CustomTextField(
                    hintText: 'Nome completo',
                    icon: Icons.person,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: buttonWidth,
                  child: const CustomTextField(
                    hintText: 'Senha',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: buttonWidth,
                  child: const CustomTextField(
                    hintText: 'Confirme a senha',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButtonAmbar(
                onPressed: () {
                  // Implemente a lógica de registro aqui
                },
                text: 'Registrar',
                height: 48.0, // Mantendo a altura do botão consistente
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Já tem uma conta? Faça login aqui',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
