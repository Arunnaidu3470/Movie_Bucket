import 'package:flutter/material.dart';

import '../../Root.dart';
import '../../constants/assets_constants.dart';
import '../../models/user_model.dart';
import '../../services/auth/authentication.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(child: Text('Movie Bucket')),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton.extended(
        icon: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(AssetsConstants.GOOGLE_LOGO),
        ),
        onPressed: () {
          _handleSignIn();
        },
        label: Text('Get in'));
  }

  _handleSignIn() async {
    User user = await AuthServices.signInWithGoogle();
    if (user == null) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (cxt) {
      return RootPage(
        currentUser: user,
      );
    }));
  }
}
