import 'package:flutter/material.dart';
import 'package:highfives_ui/screens/login/demo_login.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HighFives',
      theme: ThemeData(
        primarySwatch: Provider.of<Color>(context),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DemoLogin(),
    );
  }
}