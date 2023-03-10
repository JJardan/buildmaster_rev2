import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';
import '../../main.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  UserModel? _userModel;

  User? get user => _user;
  UserModel? get userModel => _userModel;

  UserProvider() {
    initUser();
  }

  Future initUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _user = user;

      if (user == null) {
        logger.d('User is currently signed out!');
      } else {
        logger.d('User is signed in!');
      }

      if (UserService().getUserModel(user!.uid) != null)
        await _getUser(user);
      else if (user == null && user.uid == null) await _setNewUser(user);
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    _user = user;
    if (user != null && user.email != null) {
      String userKey = user.uid;
      String userEmail = user.email!;
      UserModel userModel = UserModel(
        userKey: userKey,
        userEmail: userEmail,
        profileName: 'builder',
        profileImageUrl: "",
        profileNationality: 'global',
        careers: [],
        varifiedUserEmail: false,
        workingAbroad: false,
        findWork: false,
        signupDate: DateTime.now().toUtc(),
      );

      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson());
    }
  }

  Future _getUser(User? user) async {
    _user = user;
    _userModel = await UserService().getUserModel(user!.uid);
    logger.d(_userModel!.toJson());
  }

  /// SignInMethod
  Future signInUser(_emailController, _passwordController, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email')
        SnackBar snackbar = SnackBar(content: Text('????????? ????????? ???????????????'));
      else if (e.code == 'user-disabled')
        SnackBar snackbar = SnackBar(content: Text('????????? ???????????? ?????? ????????????'));
      else if (e.code == 'user-not-found')
        SnackBar snackbar = SnackBar(content: Text('????????? ?????? ??? ?????????'));
      else if (e.code == 'wrong-password')
        SnackBar snackbar = SnackBar(content: Text('??????????????? ?????????????'));
    }
  }

  /// SignUpMethod
  Future signUpUser(_emailController, _passwordController,
      _passwordCheckController, context) async {
    if (true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        _emailController.clear();
        _passwordController.clear();
        _passwordCheckController.clear();

        logger.d(userCredential);

        /// Firebase Cloud ??? ??????

        if (FirebaseAuth.instance.currentUser != null) {
          UserModel userModel = UserModel(
              signupDate: DateTime.now().toUtc(),
              userEmail: _emailController.text,
              userKey: FirebaseAuth.instance.currentUser!.uid,
              profileName: 'builder',
              profileImageUrl: "",
              profileNationality: 'global',
              varifiedUserEmail: false,
              workingAbroad: false,
              findWork: false,
              careers: []);
          await UserService()
              .createNewUser(userModel.toJson(), userModel.userKey);

          logger.d(FirebaseAuth.instance.currentUser!.uid);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use')
          SnackBar snackbar = SnackBar(content: Text('???????????? ?????? ??????????????????'));
        else if (e.code == 'invalid-email')
          SnackBar snackbar = SnackBar(content: Text('???????????? ?????? ??????????????????'));
        else if (e.code == 'operation-not-allowed')
          SnackBar snackbar = SnackBar(content: Text('???????????? ?????? ????????? ???????????????'));
        else if (e.code == 'weak-password')
          SnackBar snackbar = SnackBar(content: Text('??????????????? ?????????????'));
      }
    }
  }
}
