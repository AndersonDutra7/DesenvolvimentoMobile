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

    void showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro"),
            content: Text(message),
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

    Future<bool> isEmailInUse(String email) async {
      try {
        final result =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        return result.isNotEmpty;
      } catch (e) {
        return false;
      }
    }

    void registerUser(BuildContext context) async {
      List<String> emptyFields = [
        if (nameController.text.isEmpty) "Nome de usuário",
        if (emailController.text.isEmpty) "E-mail",
        if (passwordController.text.isEmpty) "Senha",
        if (phoneController.text.isEmpty) "Telefone",
        if (addressController.text.isEmpty) "Endereço"
      ];

      if (emptyFields.isNotEmpty) {
        showErrorDialog(context, "Favor, preencher todos os campos.");
        return;
      }

      String username = nameController.text.trim();
      if (username.replaceAll(' ', '').length < 7 ||
          !RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(username)) {
        showErrorDialog(context,
            "Nome inválido. Favor preencher apenas com letras e números, no mínimo 7 caracteres! Espaços são permitidos.");
        return;
      }

      String email = emailController.text;
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        showErrorDialog(context, "Favor inserir um e-mail válido.");
        return;
      }

      if (await isEmailInUse(email)) {
        showErrorDialog(
            context, "Este e-mail já está em uso. Favor informe outro.");
        return;
      }

      String phone = phoneController.text;
      String formattedPhone = formatPhone(phone);
      if (formattedPhone.isEmpty) {
        showErrorDialog(context,
            "Telefone inválido.Favor digite somente números no padrão 99-99999.9999");
        return;
      }

      String address = addressController.text;
      String password = passwordController.text;
      if (address.length < 10) {
        showErrorDialog(context,
            "Campo inválido. Favor, o campo endereço deve conter no mínimo 10 caracteres.");
        if (password.length < 7) {
          showErrorDialog(context,
              "Campo inválido. Favor, o campo senha deve conter no mínimo 7 caracterese não pode conter espaços.");
        }
        return;
      }

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
          'phone': formattedPhone,
          'address': addressController.text,
          'favoriteProducts': [],
          'cart': [],
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
        showErrorDialog(context, errorMessage);
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
                    keyboardType: TextInputType.number,
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
                  registerUser(context);
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

  static String formatPhone(String phone) {
    String digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) {
      return '';
    }
    String formattedPhone = digits.replaceFirstMapped(
        RegExp(r'^(\d{2})(\d{5})(\d{4})$'),
        (match) => '${match[1]}-${match[2]}-${match[3]}');
    return formattedPhone;
  }
}
