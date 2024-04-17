import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycallendar/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../services/auth_google_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routname = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserProvider userProvider;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _userData());
  }

  Widget _userData() {
    String userName = currentUser?.providerData[0].displayName ?? "Bienvenid@!";
    String avatar = currentUser?.photoURL ?? '';

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: avatar.isNotEmpty
                ? Image.network(
                    avatar,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )
              : Image.asset(
                'assets/teideequilibrio.jpeg',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              )),
          Text(
            "🚀 $userName 🚀",
            style: const TextStyle(
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
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
