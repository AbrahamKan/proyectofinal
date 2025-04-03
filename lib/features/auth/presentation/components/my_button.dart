import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        //PADDING INSIDE
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          //COLOR OF BUTTON
          color: Theme.of(context).colorScheme.tertiary,

          //CURVED CORNERS
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
           ),
        ),
      ),
    );
  }
}