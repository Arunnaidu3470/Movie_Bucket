import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'app/ui/screens/home_screen.dart';
import 'themes/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Bucket',
      theme: lightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MoviePopularBloc>(create: (cxt) => MoviePopularBloc())
        ],
        child: HomePageScreen(),
      ),
    );
  }
}
