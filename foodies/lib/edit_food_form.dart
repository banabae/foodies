import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class EditFoodForm extends StatefulWidget {

  final List list;
  final int index;

  const EditFoodForm({required this.list, required this.index});

  @override
  _EditFoodForm createState()=> _EditFoodForm(list: this.list, index: this.index);
  
}


class _EditFoodForm extends State<EditFoodForm> {
  final List list;
  final int index;

  _EditFoodForm({required this.list, required this.index});

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

  TextEditingController id = TextEditingController();
  TextEditingController food_nama = TextEditingController();
  TextEditingController price     = TextEditingController();
  TextEditingController quantity  = TextEditingController();

  @override
  void initState(){
    if (widget.index != null) {
      id.text = widget.list[widget.index]["id_food"];
      food_nama.text = widget.list[widget.index]["food_name"];
      price.text     = widget.list[widget.index]["price"];
      quantity.text  = widget.list[widget.index]["quantity"];
      
    }
  }
  // TextEditingController image  = TextEditingController();

  Future EditFoodFormFunction() async{
    var url = Uri.parse("http://192.168.19.115/foodies_api/edit_food.php");
    var req = await http.MultipartRequest('POST', url);
    if (_image != "") {
      var getImg = await http.MultipartFile.fromPath("image", _image!.path, filename: _image!.path.split("/").last);
      req.files.add(getImg);
    }else{
      _image = File("");
      var getImg = await http.MultipartFile.fromPath("image", _image!.path, filename: _image!.path.split("/").last);
      req.files.add(getImg);
    }
    req.fields['id']        = id.text;
    req.fields['food_name'] = food_nama.text;
    req.fields['price']     = price.text;
    req.fields['quantity']  = quantity.text;

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
        title: Text("Edit Food"),
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
                    "Form Edit Food",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        "http://192.168.19.115/foodies_api/assets/food/"+list[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
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
                          enabled: false,
                          controller: id,
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
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white24,
                              )
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                            ),
                            labelText: "ID Makanan",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
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
                              EditFoodFormFunction(); 
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