import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'components.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(viewModel).authStateChange;
});

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  Logger logger = Logger();
  bool isObscure = true;
  Stream<User?> get authStateChange => _auth.authStateChanges();
  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  //Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

//Register
  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) =>DialogBox(context, "Register Sucessfull..Please Login Now"),
        )
        .onError((error, stackTrace) {
      logger.d(error);
      DialogBox(
        context,
        error.toString().replaceAll(RegExp('\\[.*?\\]'), ' '),
      );
    });
  }

//Login
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d('Login Sucessfull'))
        .onError((error, stackTrace) {
      logger.d(error);
      DialogBox(
        context,
        error.toString().replaceAll(RegExp('\\[.*?\\]'), ' '),
      );
    });
  }

  //Google SignIn Web
  Future<void> signInWithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth
        .signInWithPopup(googleAuthProvider)
        .onError((error, stackTrace) => DialogBox(
              context,
              error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
            ));
    logger
        .d("Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}");
  }

  Future<void> signInWithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().onError((error, stackTrace) => DialogBox(
              context,
              error.toString().replaceAll(RegExp('\\[.*?\\]'), ''),
            ));
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await _auth.signInWithCredential(credential).then((value) {
      logger.e("Signed in successfully");
    }).onError((error, stackTrace) {
      logger.d(error);
    });
  }
}
