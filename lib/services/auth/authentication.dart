import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user_model.dart';

class AuthServices {
  static final GoogleSignIn _gAuth = GoogleSignIn();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///SignIn with Google account
  ///
  ///Returns [FirebaseUser] or null
  static Future<User> signInWithGoogle() async {
    GoogleSignInAccount account;
    GoogleSignInAuthentication authentication;
    AuthCredential credential;
    try {
      try {
        account = await _gAuth.signIn();
      } catch (e) {
        print(e);
      }
      authentication = await account.authentication;
      credential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      print(
          '${user.displayName}, ${user.email}, ${user.phoneNumber}, ${user.photoUrl}');
      User currentUser = User.fromFirebaseUser(user);
      return currentUser;
    } on PlatformException {
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///SignOut currentuser
  ///
  ///Returns [true] if operation success
  ///else [False]
  static Future<bool> signOutWithGoogle() async {
    try {
      print(await _gAuth.isSignedIn());
      if (!await _gAuth.isSignedIn()) return false;
      _gAuth.signOut();
      _gAuth.currentUser.clearAuthCache();
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e.toString() +
          '------------------------121---------------------------');
      return false;
    }
  }

  static Future<User> get currentUser async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return User.fromFirebaseUser(user);
  }
}
