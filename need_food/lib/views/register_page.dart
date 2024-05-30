import 'package:flutter/material.dart';
import 'package:need_food/components/custom_text_field.dart';
import 'package:need_food/views/login_page.dart';
import 'login_page.dart'; // Importe a página de login aqui

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/logo.png'),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'Nome de usuário',
                icon: Icons.person,
              ),
              const CustomTextField(
                hintText: 'Senha',
                icon: Icons.lock,
                isPassword: true,
              ),
              const CustomTextField(
                hintText: 'Confirme a senha',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implemente a lógica de registro aqui
                },
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Navegue para a página de login quando clicar no link
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Já tem uma conta? Faça login aqui',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
