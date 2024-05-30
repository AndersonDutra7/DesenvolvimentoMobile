import 'package:flutter/material.dart';
import 'package:need_food/components/custom_text_field.dart';
import 'package:need_food/views/register_page.dart'; // Corrigindo a importação aqui

class LoginPage extends StatelessWidget {
  const LoginPage({super.key}); // Corrigindo a definição do construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'lib/assets/logo.png'), // Substitua 'assets/logo.png' pelo caminho da sua logo
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implemente a lógica de login aqui
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Navegue para a página de cadastro quando clicar no link
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const RegistroPage()), // Corrigindo o nome da página aqui
                  );
                },
                child: const Text(
                  'Não tem uma conta? Cadastre-se aqui',
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
