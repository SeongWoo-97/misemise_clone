import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:misemise_clone/Class/CurrentLocationProvider.dart';
import 'package:misemise_clone/Class/FavoriteProvider.dart';
import 'package:misemise_clone/Class/StationOnMapProvider.dart';
import 'package:provider/provider.dart';

import 'Screen/SplashScreen.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentLocationProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => StationOnMapProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 14, color: Colors.white),
          )),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
