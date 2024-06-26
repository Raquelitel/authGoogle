// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycallendar/providers/user_provider.dart';
import 'package:mycallendar/screens/home_screen.dart';
import 'package:mycallendar/services/auth_google_service.dart';
import 'package:provider/provider.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton.icon(
        onPressed: () async {
          try {
            final authGoogleService = AuthGoogleService();
            final user = await authGoogleService.singInWithGoogle();

            if (user != null) {
              final userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              userProvider.setUser(user);

              print(user);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          } on FirebaseAuthException catch (error) {
            print(error.message);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error.message ?? 'Upss... algo salió mal')));
          } catch (error) {
            print(error);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error en la conexión")));
          }
        },
        icon: Image.asset(
          'assets/google_icon.png',
          scale: 35,
        ),
        label: const Text('Entra con Google'),
      ),
    );
  }
}
