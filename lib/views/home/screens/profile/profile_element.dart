import 'package:flutter/material.dart';

class ProfileElement extends StatelessWidget {
  const ProfileElement({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Column(
          children: children,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Divider(),
        ),
      ],
    );
  }
}
