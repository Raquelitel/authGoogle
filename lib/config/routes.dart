import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:mycallendar/screens/home_screen.dart';
import 'package:mycallendar/screens/login_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routname,
      builder: (context, state) {
        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen())
  ],
  redirect: (context, state) {
    return '/';
  },
);
