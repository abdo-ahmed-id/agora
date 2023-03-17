// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import '../shared_theme/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onTap});

  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: secondryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 45,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Color(0xff2B475E),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )),
      ),
    );
  }
}
