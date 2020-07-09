import 'package:flutter/material.dart';
import 'login.dart';

class Recordario extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<Recordario> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blue[800],
      title: Text('Recordatorios'),
      centerTitle: true,
      ),
       drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/imagen.jpg"),
                        fit: BoxFit.cover
                    )
                ),
                padding: EdgeInsets.all(60),
                child: Text("       MENÚ:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.blue[800]),
                title: Text("Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Login()
                    ));
                },
              ),
            ],
          ),
        ),
    );
  }
}