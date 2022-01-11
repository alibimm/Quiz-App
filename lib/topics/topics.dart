import 'package:flutter/material.dart';
import 'package:quizapp/shared/bottom_navbar.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}