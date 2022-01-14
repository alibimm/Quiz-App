import 'package:flutter/material.dart';
import 'package:quizapp/service/models.dart';
import 'package:quizapp/shared/progress_bar.dart';
import 'package:quizapp/topics/drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: SizedBox(
                  child: Image.asset(
                    'assets/covers/${topic.img}',
                    fit: BoxFit.contain,
                  ),
                ),
                flex: 3,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              Flexible(
                child: TopicProgress(
                  topic: topic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;
  const TopicScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: topic.img,
            child: Image.asset(
              'assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            topic.title,
            style: const TextStyle(
              height: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          QuizList(topic: topic),
        ],
      ),
    );
  }
}
