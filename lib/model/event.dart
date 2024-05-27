import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Event {
  final String title;
  final String description;
  final String type;
  final String room;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String partner;
  final String category;

  const Event({
    required this.title,
    required this.description,
    required this.type,
    required this.room,
    required this.timeStart,
    required this.timeEnd,
    required this.partner,
    required this.category,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json[FirestoreEventsFields.title],
      description: json[FirestoreEventsFields.description],
      type: json[FirestoreEventsFields.type],
      room: json[FirestoreEventsFields.room],
      timeStart: (json[FirestoreEventsFields.timeStart] as Timestamp).toDate(),
      timeEnd: (json[FirestoreEventsFields.timeEnd] as Timestamp).toDate(),
      partner: json[FirestoreEventsFields.partner],
      category: json[FirestoreEventsFields.category],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Event &&
            runtimeType == other.runtimeType &&
            title == other.title &&
            description == other.description &&
            type == other.type &&
            room == other.room &&
            timeStart == other.timeStart &&
            timeEnd == other.timeEnd &&
            partner == other.partner &&
            category == other.category;
  }

  @override
  int get hashCode => Object.hashAll(
        [
          title,
          description,
          type,
          room,
          timeStart,
          timeEnd,
          partner,
          category,
        ],
      );
}
