import 'package:flutter/material.dart';

@immutable
class TopPlayer {
  final String displayName;
  final int gainedPoints;

  const TopPlayer({
    required this.displayName,
    required this.gainedPoints,
  });
}
