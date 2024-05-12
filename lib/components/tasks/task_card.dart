import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  final String title;
  final String subtitle;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: SizedBox(
        height: 80,
        child: Center(
          child: Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              trailing: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "$points",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Opacity(
                opacity: 0.8,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
              textColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
