import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_bridge/screens/home_screen.dart';
import 'package:sign_bridge/screens/mainscreen.dart';
import 'package:sign_bridge/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: bgColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
          bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
          titleLarge: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
          titleMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
          titleSmall: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ).copyWith(fontFamily: 'poppins'),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const Mainscreen();
          }
        },
      ),
    );
  }
}
