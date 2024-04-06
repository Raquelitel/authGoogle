import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
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
        body: _user == null ? Center(child: _googleButton()) : _userData());
  }

  Widget _googleButton() {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton.icon(
        onPressed: _handleGoogleSignIn,
        icon: Image.asset(
          'assets/google_icon.png',
          scale: 35,
        ),
        label: const Text('Entra con Google'),
      ),
    );
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
          TextButton(onPressed: _logout, child: const Text("Cerrar Sesión"))
        ]),
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }

  void _logout() {
    try {
      _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
