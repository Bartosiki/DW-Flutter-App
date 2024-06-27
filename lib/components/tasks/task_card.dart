import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.isDone,
  });

  final String title, subtitle;
  final int points;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
          child: Card(
            color: isDone
                ? Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.1)
                : null,
            child: ListTile(
              trailing: CircleAvatar(
                backgroundColor: isDone
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.4)
                    : Theme.of(context).colorScheme.primary,
                child: Text(
                  points.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  color: isDone
                      ? Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.5)
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Opacity(
                opacity: 0.6,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: isDone
                        ? Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.5)
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
