// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycallendar/screens/login_screen.dart';
import 'package:mycallendar/widgets/google_button.dart';

import '../services/auth_google_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routname = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _user == null ? const Center(child: GoogleButton()) : _userData());
  }

  Widget _userData() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/teideequilibrio.jpeg',
                fit: BoxFit.cover,
              )),
          const Text(
            "🚀 Raquel Martín 🚀",
            style: TextStyle(
                fontSize: 24,
                fontFamily: AutofillHints.name,
                fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: _logOut, child: const Text("Cerrar Sesión"))
        ]),
      ),
    );
  }

  void _logOut() {
    final authGoogleService = AuthGoogleService();
    try {
      authGoogleService.logOut();
      Navigator.popAndPushNamed(context, LoginScreen.routename);
    } catch (e) {
      print('error');
    }
  }
}
