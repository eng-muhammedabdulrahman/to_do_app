import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_strings.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // title: 'To-Do App',
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
