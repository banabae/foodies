import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/auth/register.dart';
import 'package:foodies/home.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_session/flutter_session.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState()=> _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async{
    var url = Uri.parse("http://192.168.19.115/foodies_api/login_auth.php");
    var response = await http.post(
      url,
      body: {
        "email" : email.text,
        "password" : pass.text,
      }
    );
    var data = json.decode(response.body);
    if (data['status'] == "Success") {
      // ini session
      await FlutterSession().set("name", data['name']);
      await FlutterSession().set("email", email.text);

      Fluttertoast.showToast(
        msg: "Login Berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16 ,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
    } else {
      Fluttertoast.showToast(
        msg: "Email dan Password Salah!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16 
      );
    }
  }

  Future daftar() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Register()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        color: const Color(0xff62A075),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xff62A075),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: email,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        size: 25,
                        color: Colors.white,
                      ),
                      hintText: "Masukkan email",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      labelText: "email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: pass,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        )
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 25,
                        color: Colors.white,
                      ),
                      hintText: "Masukkan Password",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      child: const Text(
                        "Belum punya akun? Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      onTap: ()=> daftar(),
                    )
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    margin: const EdgeInsets.only(top: 30.0),
                    child: MaterialButton(
                      color: Colors.white,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff62A075),
                        ),
                      ),
                      onPressed: () { 
                        login(); 
                      },
                      
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}