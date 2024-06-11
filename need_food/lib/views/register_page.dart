import 'package:flutter/material.dart';
import 'package:need_food/components/custom_button_ambar.dart';
import 'package:need_food/components/custom_avatar.dart';
import 'package:need_food/components/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    Future<void> registerUser(BuildContext context) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'favoriteProducts':
              [], // Adiciona o campo favoriteProducts como uma lista vazia
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Sucesso"),
              content: const Text("Usuário registrado com sucesso."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = "A senha é muito fraca.";
        } else if (e.code == 'email-already-in-use') {
          errorMessage = "Este e-mail já está em uso.";
        } else {
          errorMessage = "Ocorreu um erro durante o registro.";
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
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF8B4513),
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
                  child: CustomTextField(
                    controller: nameController,
                    hintText: 'Nome de usuário',
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
                    controller: emailController,
                    hintText: 'E-mail',
                    icon: Icons.email,
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
                    controller: phoneController,
                    hintText: 'Telefone',
                    icon: Icons.phone,
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
                    controller: addressController,
                    hintText: 'Endereço',
                    icon: Icons.home,
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
                  if (nameController.text.length < 7 ||
                      !nameController.text.contains(RegExp(r'[0-9]')) ||
                      !nameController.text.contains(RegExp(r'[a-zA-Z]'))) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Erro"),
                          content: const Text(
                              "O nome deve ter pelo menos 7 caracteres e conter letras e números."),
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
                  } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                      .hasMatch(emailController.text)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Erro"),
                          content:
                              const Text("Por favor, insira um e-mail válido."),
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
                  } else {
                    registerUser(context);
                  }
                },
                text: 'Registrar',
                height: 48.0,
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
