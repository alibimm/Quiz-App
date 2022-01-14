import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/service/auth.dart';
import 'package:quizapp/service/models.dart';
import 'package:quizapp/shared/loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : const AssetImage('assets/user.png')) as ImageProvider,
                  ),
                ),
              ),
              Text(
                user.email ?? '',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              Text(
                '${report.total}',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Quizzes Completed',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('Sign out'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    }
    return const Loader();
  }
}
