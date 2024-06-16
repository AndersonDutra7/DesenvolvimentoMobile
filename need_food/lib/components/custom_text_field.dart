import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // Adicionando keyboardType como parâmetro

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType, // Recebendo keyboardType como opcional
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 50.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  obscureText: widget.isPassword,
                  keyboardType: widget.keyboardType, // Definindo keyboardType
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    counterText: "",
                    border: InputBorder.none,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  // Função para validar se o campo está vazio
  bool get isEmpty {
    return _controller.text.isEmpty;
  }

  // Função para validar o campo de telefone
  String validatePhone() {
    String phone = _controller.text;
    if (phone.isEmpty) {
      return "Campo obrigatório";
    }
    // Remover caracteres não numéricos
    String digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10 || digits.length > 11) {
      return "Telefone inválido";
    }
    // Formatando para o padrão "48-999999999" com 8 ou 9 dígitos depois do hífen
    String formattedPhone = digits.replaceFirstMapped(
        RegExp(r'^(\d{2})(\d{4,5})(\d{4})$'),
        (match) => '${match[1]}-${match[2]}-${match[3]}');
    return formattedPhone;
  }
}
