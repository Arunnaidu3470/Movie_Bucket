import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  final String uid;
  final String name;
  final String email;
  final String profileUrl;
  final String phoneNumber;

  User({this.uid, this.name, this.email, this.profileUrl, this.phoneNumber});

  ///Returns a [User] object by taking [FirebaseUser] as parameter
  factory User.fromFirebaseUser(FirebaseUser user) {
    if (user == null) return null;
    User currentUser = User(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      profileUrl: user.photoUrl,
      phoneNumber: user.phoneNumber,
    );
    return currentUser;
  }

  ///Get current object data as [Map]
  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'profile_url': this.profileUrl,
      'phone_number': this.phoneNumber,
    };
  }

  ///Copy with existing data
  User copyWidth(
      {String uid,
      String name,
      String email,
      String profileUrl,
      String phoneNumber}) {
    return User(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        profileUrl: profileUrl ?? this.profileUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  User copyWithFirebase(FirebaseUser user) {
    User currentUser = User(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      profileUrl: user.photoUrl,
      phoneNumber: user.phoneNumber,
    );
    notifyListeners();
    return currentUser;
  }
}
