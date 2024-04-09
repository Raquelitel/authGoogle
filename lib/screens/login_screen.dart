import 'package:flutter/material.dart';
import 'package:mycallendar/widgets/google_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    body: SafeArea(child: Column( 
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(
      child: GoogleButton())],)),
    );
  }
}
