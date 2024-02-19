// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  String hintText;
  Icon icon;
  final bool obscureText;
  TextInputAction action;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;

  MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon,
      required this.obscureText,
      required this.action,
      required this.validator,
      required this.onSaved,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: action,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          prefixIcon: icon,
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade200,
          hintStyle: const TextStyle(color: Colors.grey,),
        ),
      ),
    );
  }
}
