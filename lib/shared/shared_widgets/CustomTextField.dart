import 'package:flutter/material.dart';

import 'package:agoratestapp/shared/shared_theme/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? icon;
  final String hintText;
  final bool isSecure;
  final Function? validator;
  final TextInputType textType;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.icon,
    this.hintText = "",
    this.isSecure = false,
    this.validator,
    this.textType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isSecure,
      keyboardType: textType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validator!();
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "LouisGeorgeCafeBold",
            fontSize: 18,
            color: Colors.black.withOpacity(0.3)),
        filled: true,
        fillColor: Colors.black.withOpacity(0.03),
        prefixIcon: icon,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        errorBorder: customBorder(Colors.red),
      ),
    );
  }

  InputBorder customBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 0.5),
        borderRadius: BorderRadius.circular(20));
  }
}
