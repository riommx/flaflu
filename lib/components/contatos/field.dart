import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool validate;
  final IconData? icon;
  final TextInputType? keyboardType;

  // ignore: use_key_in_widget_constructors
  const Field(
      {required this.controller,
      required this.labelText,
      required this.hintText,
      required this.validate,
      this.icon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? keyboardType,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
          errorText: validate ? 'Este campo não pode ser vazio' : null,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0XFF97ace5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
