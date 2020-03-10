// import 'package:project/Authentication.dart';
// import 'Googlemaps.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:project/Googlemaps.dart';
import 'package:project/update.dart';


void main() => runApp(MyApp());

String email='';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking Device',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'tracking device'),
      routes: <String,WidgetBuilder>{
        '/Google': (BuildContext context)=> new Google(),
        
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final address = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
           new Padding(
            padding: EdgeInsets.only(top: 180),),
         
          new Center(
        ),
        new Container( 
            padding: EdgeInsets.only(top: 20),
            child:Material(
                elevation: 4.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('images/logogo.jpg'),
                  fit: BoxFit.cover,
                  width: 300.0,
                  height: 300.0,
                  child: InkWell(
                    onTap: () {
                     getcoordinates();
                     Navigator.push(context,MaterialPageRoute(builder: (context) => GetCoordinates()));
                    },
                  ),
                ),
            ),
        ), 
       new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 50)),
              SizedBox(width: 20.0, height: 100.0),
              RotateAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: ["D.E.N.R", "REGION-10", "D.E.N.R","REGION-10"
                ,"D.E.N.R", "REGION-10", "D.E.N.R","REGION-10"
                ,"D.E.N.R", "REGION-10", "D.E.N.R","REGION-10"
                ,"D.E.N.R", "REGION-10", "D.E.N.R","REGION-10"
                ,"D.E.N.R", "REGION-10", "D.E.N.R","REGION-10"],
                textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GetCoordinates extends StatefulWidget {
  GetCoordinates({Key key, this.title}) : super(key: key);

  final String title;
 

  @override
  _GetCoordinatesState createState() => _GetCoordinatesState();
}

class _GetCoordinatesState extends State<GetCoordinates> {

 




  final search = TextEditingController();
  List<Post> posts = List();
  List<Post> filteredUsers = List();
   
   
@override
void initState() { 
  super.initState();
  getcoordinates().then((usersFromServer) {
    setState(() {
      posts = usersFromServer;
      filteredUsers = posts;
      
    });
  });
  
}

TextEditingController code = new TextEditingController();


createAlertDialog(BuildContext context, int index){
 
  return showDialog(
    context: context,
    builder: (BuildContext context){
        return Dialog(
          
    
         child: Container(
           height: 100,
           width: 100,
           child: Padding(
             padding: EdgeInsets.all(0),
             child: Column(
              
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(left: 100)),
                   new Container(
                     height: 40,
                     width: 80,
                     child: TextField(
                      controller: code,
                      obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Code',),
                ),
                ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: new RaisedButton(
                          child: Text("OK"),
                          onPressed: (){
                          if(code.text=="denr") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Google(longitude: filteredUsers[index].longitude, latitude: filteredUsers[index].latitude)));
                          }else{
                            Navigator.pop(context);
                          }
                        }
                        ),
                      ),
                    ],
                  )
                ],
               ),
             ),
             
         )
        );
    }
  );
}




  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column( 
          
          children:<Widget>[
            new Container(
              child: Column(
                children: <Widget>[
                 new Container(
                    height: 350,
                    width: 430,
                            decoration: BoxDecoration(
                        image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.5), BlendMode.dstATop),
                        image: AssetImage("images/head.png"),
                        fit: BoxFit.cover,
                      )
                    ),
                    child: Column(
                      children: <Widget>[
                        new Padding(
                                        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                                        child: TextField(
                                        decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                                  borderRadius: new BorderRadius.circular(25.0),
                                                  borderSide: new BorderSide(
                                                  ),
                                                ),
                                                  contentPadding: EdgeInsets.all(10),
                                                  hintText: "Search Bar"
                                            ),
                                        controller: search,
                                        onChanged: (string){

                                setState(() {
                                      filteredUsers = posts.where((u) =>
                                      (u.latitude.toLowerCase().contains(string.toLowerCase()) || 
                                      u.longitude.toLowerCase().contains(string.toLowerCase()) ||
                                      u.coordinatesid.toLowerCase().contains(string.toLowerCase()) ||
                                      u.drivername.toLowerCase().contains(string.toLowerCase()) || 
                                      u.platenumber.toLowerCase().contains(string.toLowerCase()))).toList();
                                });
                              },
                            ),
                          ),
                          new Padding(padding: EdgeInsets.only(top:40)),
                           new Text(" GPS - BASED ", 
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 40,
                             fontFamily: "valuoldcaps",
                             color: Color.fromARGB(254, 0, 74, 73),
                           ),
                           ),
                           new Padding(padding: EdgeInsets.only(top:10)),
                          new Text("Official Vehicle ", 
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,
                             fontFamily: "valuoldcaps",
                             color: Color.fromARGB(254, 0, 74, 73),
                           ),),
                          new Padding(padding: EdgeInsets.only(top:10)),
                          new Text(" Locator ", 
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 30,
                             fontFamily: "valuoldcaps",
                             color: Color.fromARGB(254, 0, 74, 73),
                           ),),
                        
                      ],
                    ),
            ),
                ],
              )
          ),
             new Padding(
            padding: EdgeInsets.only(top: 10),),
              new Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white70,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: <Widget>[
                            new Text(
                                 "ID: " + filteredUsers[index].platenumber,
                            style: TextStyle(
                              
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                              ),
                            ),
                            new SizedBox(height: 5.0,),
                             new Text(
                                 "Driver Name: " + filteredUsers[index].drivername,
                            style: TextStyle(
                              
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, 
                              ),
                            ),
                            
                            new SizedBox(height: 5.0,),
                            new Text(
                                  "Date of travel:"+"    "+filteredUsers[index].dateoftravel , 
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,

                            ),
                            ),
                             new SizedBox(height: 5.0,),
                            new Text(
                                  "Destination:"+"    "+filteredUsers[index].destination , 
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,

                            ),
                            ),
                            new SizedBox(height: 5.0,),
                            // new Text(
                            //       filteredUsers[index].longitude + "                 " + filteredUsers[index].latitude , 
                            // style: TextStyle(
                            //   fontSize: 12.0,
                            //   color: Colors.white70,

                            // ),
                            // ),
                            
                             new Row(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(left: 300)),
                               new Container(
                            
                            child: IconButton(icon: Icon(Icons.location_on), 
                            onPressed: (){
                                             createAlertDialog(context,  index);               
                            }),
                          
                          ),
                            ],
                          ),
                             new FlatButton(
                              onPressed: () {
                                Navigator.push( context,MaterialPageRoute(builder: (context) => UpdateDriver(coordinatesid: filteredUsers[index].coordinatesid)));                              
                            }, child: Text("update"),
                          ),
                         

                          ],
                        ),
                      )

                    );
                  },
                ),
              )     
      ]
      ),
      ),
    );
  }
}

	
  class Post {
    
    String latitude;
    String longitude;
    String platenumber;
    String drivername;
    String coordinatesid;
    String dateoftravel;
    String destination;
    
    
 
    Post({this.latitude, this.longitude, this.platenumber,this.drivername, this.coordinatesid, this.dateoftravel, this.destination});
    factory Post.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
  }
 
  Post _itemFromJson(Map<String, dynamic> json) => Post(

      latitude: json['latitude'].toString(),
      coordinatesid: json['coordinatesid'].toString(),
      longitude: json['longitude'].toString(),
      platenumber: json['platenumber'].toString(),
      drivername: json['drivername'].toString(),
      dateoftravel: json['dateoftravel'].toString(),
      destination: json['destination'].toString(),
      
      
  );

Future<List<Post>> getcoordinates() async {
  http.Response response =
  await http.get("http://192.168.1.21/coordinatesAPI/getcoordinates.php");
  List responseJson = json.decode(response.body);
  return responseJson.map((m) => new Post.fromJson(m)).toList();
}
