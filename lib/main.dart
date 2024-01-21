import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routelift_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.josefinSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
