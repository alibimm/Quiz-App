import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizapp/routes.dart';
import 'package:quizapp/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Quiz-App',
            routes: appRoutes,
            theme: appTheme,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
          );
        }

        return const MaterialApp();
      },
    );
  }
}
