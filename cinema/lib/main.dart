import 'package:flutter/material.dart';
import 'showtimepage/home.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'auth/forgetpassword.dart';
import 'showtime.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      initialRoute: '/login',

      routes: {
        '/home': (context) => const MovieHomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgetpassword': (context) => const ForgetpasswordPage(),
        '/home/movie/moviedetail': (context) => const  ShowtimeScreen(),
      },
    );
  }
}