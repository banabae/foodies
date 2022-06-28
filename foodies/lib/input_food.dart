import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class InputFood extends StatefulWidget {
  const InputFood({Key? key}) : super(key: key);


  @override
  _InputFood createState()=> _InputFood();
  
}


class _InputFood extends State<InputFood> {

  final picker = ImagePicker();
  File? _image;

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  TextEditingController food_nama = TextEditingController();
  TextEditingController price     = TextEditingController();
  TextEditingController quantity  = TextEditingController();
  // TextEditingController image  = TextEditingController();

  Future inputFoodFunction() async{
    var url = Uri.parse("http://192.168.19.115/foodies_api/add_food.php");
    var req = await http.MultipartRequest('POST', url);
    // var getImg = await http.MultipartFile.fromPath("image", _image!.path);
    var getImg = await http.MultipartFile.fromPath("image", _image!.path, filename: _image!.path.split("/").last);
    req.fields['food_name'] = food_nama.text;
    req.fields['price']     = price.text;
    req.fields['quantity']  = quantity.text;
    req.files.add(getImg);

    var response = await req.send();
    
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Data Berhasil Diinput!",
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
        msg: "Error = ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Food"),
        backgroundColor: const Color(0xff62A075),
      ),
      body: Scrollbar(
        thickness: 10,
        radius: Radius.circular(0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index){
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              color: const Color(0xff62A075),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  const Text(
                    "Form Input Food",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    child: _image == null ?
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.white
                          )
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 48,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Upload Gambar Makanan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    :
                      Image.file(_image!, height: 200, width: 200,),
                    onTap: ()=> getImage()
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: food_nama,
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
                            hintText: "Masukkan nama makanan",
                            hintStyle: TextStyle(
                              color: Colors.white
                            ),
                            labelText: "Nama Makanan",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: price,
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
                            hintText: "Masukkan harga",
                            hintStyle: TextStyle(
                              color: Colors.white
                            ),
                            labelText: "Harga Makanan",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: quantity,
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
                            hintText: "Masukkan jumlah",
                            hintStyle: TextStyle(
                              color: Colors.white
                            ),
                            labelText: "Jumlah / Quantity",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          margin: const EdgeInsets.only(top: 30.0),
                          child: MaterialButton(
                            color: Colors.white,
                            child: const Text(
                              "Simpan Data",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff62A075),
                              ),
                            ),
                            onPressed: () { 
                              inputFoodFunction(); 
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        )
      )
    );
  }
  
}