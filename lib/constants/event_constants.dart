import 'package:flutter/material.dart';

class EventConstants {
  static List<String> getCategories(String languageCode) {
    switch (languageCode) {
      case 'pl':
        return [
          'automatyzacja',
          'sztuczna inteligencja',
          'telekomunikacja',
          'biznes',
          'baza danych',
          'web',
          'mobile',
          'bezpieczeństwo',
          'usprawnienia',
          'inne',
        ];
      default:
        return [
          'automation',
          'ai',
          'telecom',
          'business',
          'database',
          'web',
          'mobile',
          'security',
          'improvement',
          'other',
        ];
    }
  }

  static IconData getIcon(String category) {
    switch (category) {
      case 'automation' || 'automatyzacja':
        return Icons.smart_toy;
      case 'ai' || 'sztuczna inteligencja':
        return Icons.psychology;
      case 'telecom' || 'telekomunikacja':
        return Icons.cell_tower;
      case 'business' || 'biznes':
        return Icons.business;
      case 'database' || 'baza danych':
        return Icons.storage;
      case 'web':
        return Icons.web;
      case 'mobile' || 'mobile':
        return Icons.smartphone;
      case 'security' || 'bezpieczeństwo':
        return Icons.security;
      case 'improvement' || 'usprawnienia':
        return Icons.lightbulb;
      case 'other' || 'inne':
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
