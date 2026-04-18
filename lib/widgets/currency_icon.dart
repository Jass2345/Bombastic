import 'package:flutter/material.dart';

class CurrencyIcon extends StatelessWidget {
  const CurrencyIcon({this.size = 18, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.monetization_on_rounded,
      size: size,
      color: const Color(0xFFFFC107),
    );
  }
}
