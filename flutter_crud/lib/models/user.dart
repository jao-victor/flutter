import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const User({
    required this.id, // esse ID não tem required
    required this.name, //aqui tem @ antes dos required
    required this.email,
    required this.avatarUrl,
  });
}
