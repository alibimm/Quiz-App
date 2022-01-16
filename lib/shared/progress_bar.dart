import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/service/models.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({Key? key, required this.value, this.height = 12.0})
      : super(key: key);
  final double height;
  final double value;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              AnimatedContainer(
                height: height,
                curve: Curves.easeInOut,
                width: box.maxWidth * _floor(value),
                duration: const Duration(microseconds: 800),
                decoration: BoxDecoration(
                  color: _getColor(value),
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  double _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  Color _getColor(double value) {
    int rgb = (255 * value).toInt();
    return Colors.deepOrange.withGreen(rgb).withRed(255 - rgb);
  }
}

class TopicProgress extends StatelessWidget {
  final Topic topic;
  const TopicProgress({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        _progressCounter(report, topic),
        Expanded(
          child: AnimatedProgressBar(
            value: _calcValue(report, topic),
            height: 8.0,
          ),
        ),
      ],
    );
  }

  Widget _progressCounter(Report report, Topic topic) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  double _calcValue(Report report, Topic topic) {
    try {
      int totalQuizzes = topic.quizzes.length;
      int completedQuizzes = report.topics[topic.id].length;
      return completedQuizzes / totalQuizzes;
    } catch (e) {
      return 0.0;
    }
  }
}
