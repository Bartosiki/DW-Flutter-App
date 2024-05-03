import 'package:flutter/material.dart';

class ScreenDescription extends StatelessWidget {
  ScreenDescription({super.key, required this.description, this.trailingIcon});

  String description;
  Widget? trailingIcon;

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
                    fontSize: 16
                )
            )
        ),
        if (trailingIcon != null) // Check if trailingIcon is not null
          const SizedBox(width: 16),
        if (trailingIcon != null) // Check if trailingIcon is not null
          IconButton(
            iconSize: 30,
            onPressed: null,
            icon: trailingIcon!
          ),
      ],
    );
  }
}
