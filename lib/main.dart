import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rik_and_morty/bloc/character_bloc.dart';
import 'package:rik_and_morty/bloc_observable.dart';
import 'package:rik_and_morty/ui/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rik_and_morty/bloc_observable.dart';
import 'package:rik_and_morty/ui/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

 runApp(const MyApp());



}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
         headline1: TextStyle(
           fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          headline3: TextStyle(
              fontSize: 24,   color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          caption: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
         )
        ),
      home: HomePage(title: 'Risk and Morty'),
      );

  }
}
