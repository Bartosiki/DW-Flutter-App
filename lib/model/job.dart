import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dw_flutter_app/constants/firestore_fields.dart';
import 'package:flutter/material.dart';

@immutable
class Job {
  final String id; // Firestore document ID
  final String title;
  final String companyName;
  final String? companyLogo;
  final String salaryRange;
  final String description;
  final String offerUrl;

  const Job({
    required this.id,
    required this.title,
    required this.companyName,
    this.companyLogo,
    required this.salaryRange,
    required this.description,
    required this.offerUrl,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      salaryRange: json['salaryRange'],
      description: json['description'],
      offerUrl: json['offerUrl'],
    );
  }

  Job copyWith({
    String? companyLogo,
  }) {
    return Job(
      id: id,
      title: title,
      companyName: companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      salaryRange: salaryRange,
      description: description,
      offerUrl: offerUrl,
    );
  }
}
