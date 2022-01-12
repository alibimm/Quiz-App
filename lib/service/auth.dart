import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> anonSignIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on Exception catch (e) {
      // TODO: show error message
    }
  }

  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      if (googleUser == null) return;
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(googleCredential);
    } on Exception catch (e) {
      // TODO: show error message
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}