import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project/main.dart';


class UpdateDriver extends StatefulWidget {
  UpdateDriver({Key key, this.title, this.coordinatesid}) : super(key: key);

  final String title;
  final String coordinatesid;
  

 

  @override
  _UpdateDriverState createState() => _UpdateDriverState(coordinatesid: coordinatesid);
}

class _UpdateDriverState extends State<UpdateDriver> {
  _UpdateDriverState({this.coordinatesid});
final String coordinatesid;

TextEditingController drivername = new TextEditingController();


 void update() {
    var url="http://192.168.1.21/coordinatesAPI/update.php";
    http.post(url,body: {
      "coordinatesid": coordinatesid,
      "drivername": drivername.text,
      
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 100)),
            new Text(coordinatesid),
            new Padding(padding: EdgeInsets.only(top: 100)),
            new Container(
              child: TextField(
                controller: drivername,
                decoration: InputDecoration(
                  labelText: "  Update Driver",
                ),
              ),
            ),
            new Padding(padding: EdgeInsets.only(top: 100)),
            new RaisedButton(onPressed: () {
                update();
                Navigator.push( context,MaterialPageRoute(builder: (context) => GetCoordinates()));                              
            },
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.white70,
            child: Text("update"),
            )
          ],
        ),
        ),
    ),

    );
  }
}