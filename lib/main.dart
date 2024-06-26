import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mycallendar/config/routes.dart';
import 'package:mycallendar/firebase_options.dart';
import 'package:mycallendar/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp.router(
          title: 'https://www.linkedin.com/in/raquelmarca/',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ));
  }
}
