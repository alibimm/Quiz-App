import 'package:flutter/material.dart';
import 'package:quizapp/service/models.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          print(topic.title);
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
          ],
        ),
      ),
    );
  }
}
