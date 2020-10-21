import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyCamera",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  color: Colors.white, fontSize: 20),
              subtitle2:
                  TextStyle(color: Colors.grey, fontSize: 20))),
    );
  }
}