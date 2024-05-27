import 'package:flutter/material.dart';

class EventConstants {
  static List<String> getCategories() => [
        'automation',
        'ai',
        'telecom',
        'company',
        'database',
        'web',
        'mobile',
        'security',
        'improvement',
        'other',
      ];
  static IconData getIcon(String category) {
    switch (category) {
      case 'automation':
        return Icons.smart_toy;
      case 'ai':
        return Icons.psychology;
      case 'telecom':
        return Icons.cell_tower;
      case 'company':
        return Icons.business;
      case 'database':
        return Icons.storage;
      case 'web':
        return Icons.web;
      case 'mobile':
        return Icons.smartphone;
      case 'security':
        return Icons.security;
      case 'improvement':
        return Icons.lightbulb;
      case 'other':
        return Icons.local_library;
      default:
        return Icons.local_library;
    }
  }

  static List<String> getAcceptedTypes() => [
        'lecture',
        'workshop',
      ];

  static String getTranslatedType(String type, String languageCode) {
    switch (type) {
      case 'lecture':
        return languageCode == 'pl' ? 'Wykład' : 'Lecture';
      case 'workshop':
        return languageCode == 'pl' ? 'Warsztat' : 'Workshop';
      default:
        return languageCode == 'pl' ? 'Inny' : 'Other';
    }
  }

  EventConstants._();
}
