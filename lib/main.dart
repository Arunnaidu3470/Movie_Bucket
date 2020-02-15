import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_bucket/Root.dart';
import 'package:provider/provider.dart';
import './pages/auth/signIn.dart';
import 'models/user_model.dart';
import 'services/auth/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        FutureProvider<User>(
          create: (_) async {
            User user = await AuthServices.currentUser;
            return user;
          },
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Movie Bucket',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        // darkTheme: ThemeData.dark(),
        home: Consumer<User>(builder: (_, user, child) {
          if (user == null) return SignInPage();
          return RootPage(
            currentUser: user,
          );
        }),
      ),
    );
  }
}
