import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yt_favs/blocs/favorite_bloc.dart';
import 'package:yt_favs/blocs/videos_bloc.dart';
import 'package:yt_favs/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBlock())
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: 'FlutterTube',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
      dependencies: [],
    );
  }
}
