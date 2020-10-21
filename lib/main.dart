import 'package:flutter/material.dart';
import 'package:gozlukstore/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contextP) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
