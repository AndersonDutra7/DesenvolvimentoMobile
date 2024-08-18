import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:need_food/components/custom_button_ambar.dart';
import 'package:need_food/components/form_field_container.dart'; // Atualizado
import 'package:need_food/views/register_page.dart';
import 'package:need_food/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: const Text('Por favor, preencha todos os campos.'),
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
      return;
    }

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
      if (e.code == 'invalid-email' ||
          e.code == 'invalid-credential' ||
          e.code == 'wrong-password') {
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

  @override
  Widget build(BuildContext context) {
    double inputHeight = 40.0;
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

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
                    FormFieldContainer(
                      hintText: 'E-mail',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    FormFieldContainer(
                      hintText: 'Senha',
                      icon: Icons.lock,
                      isPassword: true,
                      controller: passwordController,
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
