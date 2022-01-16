import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz/quiz_state.dart';
import 'package:quizapp/service/firestore.dart';
import 'package:quizapp/service/models.dart';
import 'package:quizapp/shared/loading.dart';
import 'package:quizapp/shared/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          QuizState state = Provider.of<QuizState>(context);
          if (!snapshot.hasData || snapshot.hasError) {
            return const LoadingScreen();
          }
          Quiz quiz = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: AnimatedProgressBar(value: state.progress),
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.times),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: state.controller,
              onPageChanged: (idx) =>
                  state.progress = idx / (quiz.questions.length + 1),
              itemBuilder: (context, idx) {
                if (idx == 0) {
                  return StartPage(quiz: quiz);
                } else if (idx == quiz.questions.length + 1) {
                  return CongratsPage(quiz: quiz);
                } else {
                  return QuestionPage(question: quiz.questions[idx - 1]);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizState state = Provider.of<QuizState>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline4),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: state.nextPage,
                icon: const Icon(Icons.poll),
                label: const Text('Start!'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          const Divider(),
          Image.asset('assets/congrats.gif'),
          ElevatedButton.icon(
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/topics', (route) => false);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            icon: const Icon(Icons.check),
            label: const Text('Mark completed!'),
          )
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizState state = Provider.of<QuizState>(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Text(question.text),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90.0,
                color: Colors.black26,
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          opt == state.selected
                              ? FontAwesomeIcons.checkCircle
                              : FontAwesomeIcons.circle,
                          size: 30,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  void _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(correct ? 'Good job!' : 'Wrong'),
              Text(
                opt.detail,
                style: const TextStyle(color: Colors.white54, fontSize: 18.0),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: correct ? Colors.green : Colors.red,
                ),
                child: Text(
                  correct ? 'Onward!' : 'Try again',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
