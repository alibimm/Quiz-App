import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final Stream<User?> userStream = FirebaseAuth.instance.authStateChanges();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> signInAnon() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on Exception catch (e) {
      // TODO: show error message
    }
  }

  
}