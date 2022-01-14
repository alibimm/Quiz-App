import 'package:flutter/material.dart';
import 'package:quizapp/service/firestore.dart';
import 'package:quizapp/service/models.dart';
import 'package:quizapp/shared/bottom_navbar.dart';
import 'package:quizapp/shared/error.dart';
import 'package:quizapp/shared/loading.dart';
import 'package:quizapp/topics/drawer.dart';
import 'package:quizapp/topics/topic_item.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Topics'),
              backgroundColor: Colors.deepPurple,
            ),
            drawer: TopicDrawer(topics: topics),
            bottomNavigationBar: const BottomNavBar(),
            body: GridView.count(
              primary: false,
              crossAxisSpacing: 10.0,
              padding: const EdgeInsets.all(20.0),
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
          );
        } else {
          return const Text(
              'The topics were not loaded. Please, check Firestore');
        }
      },
    );
  }
}
