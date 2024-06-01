import 'package:flutter/material.dart';
import 'package:need_food/components/custom_button_ambar.dart';
import 'package:need_food/components/custom_text_field.dart';
import 'package:need_food/views/register_page.dart';
import 'package:need_food/views/home_page.dart'; // Importamos a HomePage para redirecionamento

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double inputHeight = 40.0;
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    // Controladores para os campos de entrada
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> loginUser(BuildContext context) async {
      // Implemente a lógica de login aqui
      // Neste exemplo, estamos apenas verificando se o nome de usuário não está vazio
      if (usernameController.text.isNotEmpty) {
        // Se o login for bem-sucedido, redirecionamos para a HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Caso contrário, exibimos um pop-up informando que o nome de usuário ou senha está incorreto
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Erro"),
              content: const Text("Nome de usuário ou senha incorretos."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/logo.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: buttonWidth,
                        child: CustomTextField(
                          controller: usernameController,
                          hintText:
                              'Nome de usuário', // Alteramos o texto do placeholder
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
                        child: CustomTextField(
                          controller: passwordController,
                          hintText: 'Senha',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAmbar(
                      onPressed: () {
                        loginUser(
                            context); // Chamamos a função loginUser ao pressionar o botão de login
                      },
                      text: 'Login',
                      height: inputHeight * 1.2,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Não tem uma conta? Cadastre-se aqui',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
