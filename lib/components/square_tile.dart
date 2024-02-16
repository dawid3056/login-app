// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class SquareTail extends StatelessWidget {
  final String imagePath;

  const SquareTail({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        imagePath,
        height: 70,
        fit: BoxFit.contain,
      ),
    );
  }
}
