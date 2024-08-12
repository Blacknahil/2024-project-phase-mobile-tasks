import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressedFunction;

  const LargeButton(this.color, this.text, {this.onPressedFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressedFunction ?? () {},
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: color,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
              color == const Color(0xFFFF1313) ? Colors.white : color),
          foregroundColor: MaterialStateProperty.all(
              color == const Color(0xFFFF1313)
                  ? const Color(0xFFFF1313)
                  : const Color(0xFFFFFFFF)),
        ),
        child: Text(text),
      ),
    );
  }
}
