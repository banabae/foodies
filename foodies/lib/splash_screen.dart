import 'package:flutter/material.dart';
import 'package:foodies/auth/login.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState()=> _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  
  @override
  void initState(){
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 2);
    return Timer(duration, ()=>{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> const Login())
      )
    });
  }
   
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff62A075),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.food_bank,
              size: 100.0,
              color: Colors.white,
            ),
            SizedBox(height: 24.0),
            Text("Foodies",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0
              ),
            )
          ],
        )
      ),
    );
  }
}