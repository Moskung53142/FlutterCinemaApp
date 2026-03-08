import 'package:flutter/material.dart';

class User {
  final String name;
  final String surname;
  final String email;
  final String password;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
}

final List<User> appUser = [
  User(name: "name", surname: "surname", email: "email@email.com", password: "password123")
];
