
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.child,
    required this.label,
  }) : super(key: key);
  final Widget child;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        child,
        SizedBox(
          width: 4,
        ),
        Text(label),
      ],
    );
  }
}
