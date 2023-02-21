import 'dart:async';
import 'dart:convert' show json;
import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../connection/model/user_model.dart';
import '../../../connection/service/user_service.dart';
import '../../main.dart';

class SignInGoogle extends StatefulWidget {
  const SignInGoogle({Key? key}) : super(key: key);

  @override
  State createState() => SignInGoogleState();
}


class SignInGoogleState extends State<SignInGoogle> {

  @override
  Widget _buildBody() {
    final GoogleSignInAccount? user = BuildMasterState().currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(BuildMasterState().contactText),
          ElevatedButton(
            onPressed: BuildMasterState().handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => BuildMasterState().handleSignOut(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: () async {
              await BuildMasterState().handleSignIn();
              if (googleSignin.currentUser != null) {
                UserModel userModel = UserModel(
                  userEmail: googleSignin.currentUser!.email,
                  profileName: 'unknown',
                  profileImageUrl: "",
                  varifiedUserEmail: false,
                  careers: [],
                  signupDate: DateTime.now().toUtc(),
                  userKey: googleSignin.currentUser!.id,
                );
                UserService().createNewUser(userModel.toJson(), userModel.userKey);
                Beamer.of(context).beamToNamed('/');
              }
            },
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}