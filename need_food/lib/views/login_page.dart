import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/custom_button_ambar.dart';
import 'package:need_food/components/custom_text_field.dart';
import 'package:need_food/views/register_page.dart';
import 'package:need_food/views/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double inputHeight = 40.0;
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> loginUser(BuildContext context) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'E-mail ou senha inválidos.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'E-mail ou senha inválidos.';
        } else {
          errorMessage = 'Erro ao fazer login. Por favor, tente novamente.';
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Erro"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    emailController.clear();
                    passwordController.clear();
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
                          controller: emailController,
                          hintText: 'E-mail',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: 20),
                    CustomButtonAmbar(
                      onPressed: () {
                        loginUser(context);
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
