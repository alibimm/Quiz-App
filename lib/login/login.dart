import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/service/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlutterLogo(size: 120),
            Flexible(
              child: LoginButton(
                title: 'Continue as Guest',
                color: Colors.deepPurple,
                icon: FontAwesomeIcons.userNinja,
                loginMethod: AuthService().anonSignIn,
              ),
            ),
            Flexible(
              child: LoginButton(
                title: 'Login with Google',
                color: Colors.blue,
                icon: FontAwesomeIcons.google,
                loginMethod: AuthService().googleSignIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => loginMethod(),
          label: Text(title),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            backgroundColor: color,
          )),
    );
  }
}
