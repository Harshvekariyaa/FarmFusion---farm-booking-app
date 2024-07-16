import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          suffixText: '*',
        ),
        validator: validator,
      ),
    );
  }
}
