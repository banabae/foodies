import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/auth/register.dart';
import 'package:foodies/home.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_session/flutter_session.dart';

class SearchFood extends StatefulWidget {
  const SearchFood({Key? key}) : super(key: key);

  @override
  _SearchFoodState createState()=> _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  
  Future getData() async{
    var url = Uri.parse("http://192.168.19.115/foodies_api/view_food.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  TextEditingController cari = TextEditingController();

  Future cariData() async{
    var url = Uri.parse("http://192.168.19.115/foodies_api/search_food.php");
    var response = await http.post(
      url,
      body: {
        "cari" : cari.text,
      }
    );
    var data = json.decode(response.body);
    if (data['status'] == "Success") {
      print(data["data"]);
      Fluttertoast.showToast(
        msg: "Berhasil!"+data["data"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16 ,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Gagal!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16 ,
      );
    }
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
                return index == 0 ?
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search..."
                      ),
                      onChanged: (text){
                        text = text.toLowerCase();
                        cariData();
                      },
                    ),
                  )
                :
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "http://192.168.19.115/foodies_api/assets/food/"+list[index]["image"],
                              fit: BoxFit.cover,
                            )
                          )
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent
                                ]
                              )
                            ),
                          )
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index]['food_name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  list[index]['price'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 30,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index]['quantity'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                  ),
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
            const CircularProgressIndicator();
        }
      ),
    );
  }
}

