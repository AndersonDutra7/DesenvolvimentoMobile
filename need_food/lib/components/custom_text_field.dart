import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: _controller,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          border: InputBorder.none,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        ),
        onChanged: (value) {
          setState(() {
            // Update the state here if needed
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
