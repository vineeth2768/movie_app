import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trogen/pages/home.dart';
import 'package:trogen/provider/show_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShowProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
