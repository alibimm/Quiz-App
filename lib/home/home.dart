import 'package:flutter/material.dart';
import 'package:quizapp/login/login.dart';
import 'package:quizapp/service/auth.dart';
import 'package:quizapp/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
