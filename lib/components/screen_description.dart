import 'package:flutter/material.dart';

class ScreenDescription extends StatelessWidget {
  const ScreenDescription({
    super.key,
    required this.description,
    this.trailingIcon,
  });

  final String description;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Text(description,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16))),
        if (trailingIcon != null)
          Column(
            children: [
              const SizedBox(width: 16),
              IconButton(iconSize: 30, onPressed: null, icon: trailingIcon!),
            ],
          ),
      ],
    );
  }
}
