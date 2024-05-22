import 'package:flutter/material.dart';

class RotatingIconButton extends StatefulWidget {
  RotatingIconButton({
    super.key,
    required this.turns,
    required this.onPressed,
  });

  final void Function() onPressed;
  double turns;

  @override
  State<RotatingIconButton> createState() => _RotatingIconButtonState();
}

class _RotatingIconButtonState extends State<RotatingIconButton> {
  void _rotateIcon() {
    setState(() {
      widget.turns += 0.5 % 1;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.turns,
      duration: const Duration(milliseconds: 300),
      child: IconButton(
        icon: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.arrow_upward,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: _rotateIcon,
      ),
    );
  }
}
