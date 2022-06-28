import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/auth/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState()=> _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController nama        = TextEditingController();
  TextEditingController email       = TextEditingController();
  TextEditingController pass        = TextEditingController();
  TextEditingController gender      = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  Future register() async{
    var url = Uri.parse("http://192.168.19.106/foodies_api/register_auth.php");
    var response = await http.post(
      url,
      body: {
        "email"          : email.text,
        "password"       : pass.text,
        "name"           : nama.text,
        "gender"         : gender.text,
        "dateofbirth"    : dateofbirth.text,
        "confirmpassword": confirmpass.text,
      }
    );
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
        msg: "Register Berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16 ,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
    } else {
      Fluttertoast.showToast(
        msg: "Terdapat Data yang kurang tepat!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16 
      );
    }
  }

  Future masuk() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff62A075),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(top: 35),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 50,
                    color: Color(0xff62A075),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                "Register",
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
                      controller: nama,
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
                          Icons.person,
                          size: 25,
                          color: Colors.white,
                        ),
                        hintText: "Masukkan Nama",
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelText: "nama",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: email,
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
                      controller: gender,
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
                          Icons.looks,
                          size: 25,
                          color: Colors.white,
                        ),
                        hintText: "Masukkan Jenis Kelamin",
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelText: "Jenis Kelamin",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: dateofbirth,
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
                          Icons.date_range,
                          size: 25,
                          color: Colors.white,
                        ),
                        hintText: "Masukkan Tanggal Lahir",
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelText: "Tanggal Lahir",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: pass,
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
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: confirmpass,
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
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelText: "Konfirmasi Password",
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
                          "Sudah punya akun? Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onTap: ()=> masuk(),
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
                          "Register",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff62A075),
                          ),
                        ),
                        onPressed: () { 
                          register(); 
                        },
                        
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}