import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;

  const LabelText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
