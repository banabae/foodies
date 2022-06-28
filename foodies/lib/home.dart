import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/auth/login.dart';
import 'package:foodies/edit_food.dart';
import 'package:foodies/input_food.dart';
import 'package:foodies/list_food.dart';
import 'package:foodies/search_food.dart';
import 'package:flutter_session/flutter_session.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _MyHome createState() => _MyHome();
}


class _MyHome extends State<Home> {
  int index = 0;
  List<Widget> list = [
    const ListFood(),
    const EditFood(),
    const SearchFood(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Foodies"),
          backgroundColor: const Color(0xff62A075),
        ),
        body: list[index],
        drawer: MyDrawer(onTap: (ctx,i){
          setState(() {
            index = i;
            Navigator.pop(ctx);
          });
        }),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function onTap;

  // ignore: use_key_in_widget_constructors
  const MyDrawer({
    
    required this.onTap
  });

  Future logout(context) async{
    await FlutterSession().set("name", '');
    await FlutterSession().set("email", '');
    Fluttertoast.showToast(
        msg: "Berhasil Logout!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black54,
        fontSize: 16 ,
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
  }

  Future inputFoodLink(context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const InputFood()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff62A075)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/logos/th.jpeg'),
                      ),
                    ),
                    SizedBox(height: 15,),
                    FutureBuilder(
                      future: FlutterSession().get("name"),
                      builder: (context, snapshot){
                        return Text(
                          snapshot.hasData ? snapshot.data.toString() : "Loading...",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          )
                        );
                      }
                    ),
                    SizedBox(height: 7,),
                    FutureBuilder(
                      future: FlutterSession().get("email"),
                      builder: (context, snapshot){
                        return Text(
                          snapshot.hasData ? snapshot.data.toString() : "Loading...",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home / List Food"),
              onTap: ()=>onTap(context,0),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Input Food"),
              onTap: ()=>inputFoodLink(context),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Food"),
              onTap: ()=>onTap(context,1),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Search Food"),
              onTap: ()=>onTap(context,2),
              hoverColor: const Color(0xff62A075),
            ),
            const Divider(height: 1,),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red.shade900,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.red.shade900,
                ),
              ),
              onTap: ()=>logout(context),
            ),
          ],
        ),
      ),
    );
  }
}