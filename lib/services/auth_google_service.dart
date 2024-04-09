import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogleService {
  Future<dynamic> singInWithGoogle() async {
    final account = await GoogleSignIn().signIn();
    final googleAuth = await account?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
