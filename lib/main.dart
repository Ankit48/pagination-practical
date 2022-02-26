import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagination/listing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practical',
      theme: ThemeData(
        primaryColor: const Color(0xFF37C8C3),
        primarySwatch: Colors.teal,
      ),
      home: Listing()
    );
  }
}
