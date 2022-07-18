import 'package:flutter/material.dart';
import 'package:misemise_clone/Screen/MainScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          MainScreen(),
          Container(
            color: Colors.amber,
            child: Center(child: Text('second page')),
          )
        ],
      ),
    );
  }
}
