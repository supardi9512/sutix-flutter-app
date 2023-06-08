part of 'services.dart';

class AuthServices {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // function sign up
  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      // save ke firestore
      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      // return SignInSignUpResult(message: e.toString().split(',')[1]);
      return SignInSignUpResult(message: e.toString());
    }
  }

  // function sign in
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user!.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      // return SignInSignUpResult(message: e.toString().split(',')[1]);
      return SignInSignUpResult(message: e.toString());
    }
  }

  // Function sign out

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}

// class untuk result bisa berupa data user atau message
class SignInSignUpResult {
  final User? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}
