import 'package:flutter/material.dart';

export 'package:conexion/utils/form_validator.dart';


class Enmarcar extends StatelessWidget {
 
  final Widget child;
 
  const Enmarcar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 5
        )
      ),
      child: child,
    );
  }
}