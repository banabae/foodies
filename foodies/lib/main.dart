import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:foodies/auth/login.dart';
import 'package:foodies/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic email = FlutterSession().get("email"); 
  runApp(MaterialApp(home: email != '' ? const MyApp() : Login() ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
