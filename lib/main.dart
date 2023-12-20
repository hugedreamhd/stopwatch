import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/stop_watch_screen.dart';

void main() {
  //일정하게 지정시간을 발생시킨다

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StopWatchScreen(),
    );
  }
}
