import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/edit_food_form.dart';
import 'package:foodies/input_food.dart';
import 'package:http/http.dart' as http;

class EditFood extends StatelessWidget {
  const EditFood({Key? key}) : super(key: key);
  

  Future getData() async{
    // var url = Uri.parse("http://192.168.18.106/foodies_api/view_food.php");
    var url = Uri.parse("http://192.168.19.115/foodies_api/view_food.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                List list = snapshot.data;
                return Container(
                  margin: EdgeInsets.fromLTRB(30, 15, 30, 5),
                  height: 160,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xff62A075).withOpacity(0.5),
                                  const Color(0xff62A040).withOpacity(0.5),
                                ]
                              )
                            ),
                          )
                        )
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 15, 0, 11),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: Image.network(
                                  "http://192.168.19.115/foodies_api/assets/food/"+list[index]["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index]['food_name'],
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    list[index]['price'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 30,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 15, 0, 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index]['quantity'],
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 25, 11),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                          ],
                                  ),
                                ),
                                onTap: ()=>{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditFoodForm(list: list, index: index)))
                                },
                              ),
                              SizedBox(width: 20,),
                              GestureDetector(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red.shade900,
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Hapus",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red.shade900,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  var url = Uri.parse("http://192.168.19.115/foodies_api/delete_food.php");
                                  var response = await http.post(
                                    url,
                                    body: {
                                      'id' : list[index]['id_food']
                                    }
                                  );
                                  var dt = json.decode(response.body);
                                  if (dt == "Success") {
                                    Fluttertoast.showToast(
                                      msg: "Data Berhasil Dihapus!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16 ,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Error",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16 
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                );
              }
            )
          :
            Center(
              child: CircularProgressIndicator(),
            );
        }
      ),
    );
  }
}