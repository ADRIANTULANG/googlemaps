// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'Googlemaps.dart';

// String email = '';
// class Authentication extends StatefulWidget {
//   Authentication({Key key, this.title, this.longitude, this.latitude}) : super(key: key);

//   final String title;
//   final String longitude;
//   final String latitude;

 

//   @override
//   _AuthenticationState createState() => _AuthenticationState(longitude: longitude, latitude: latitude);
// }

// class _AuthenticationState extends State<Authentication> {
// _AuthenticationState({this.latitude, this.longitude});
// final String latitude;
// final String longitude;
// String msg = '';
// TextEditingController emailinput = new TextEditingController();
// TextEditingController password = new TextEditingController();




//   Future<dynamic> _login() async{
   
//    final response = await http.post("http://192.168.1.62/coordinatesAPI/login.php", body: {
//     "email": emailinput.text,
//     "password": password.text,
//    });

//    var datauser = json.decode(response.body);

//    if(datauser.length== 0){
//      setState(() {
//        msg="Login fail";
//      });
//    }else{
//      if(datauser[0]['usertype'] == 'admin'){
//        Navigator.push(context, MaterialPageRoute(builder: (context) => Google(longitude: longitude, latitude: latitude)));

//      }else if(datauser[0]['usertype'] == 'member'){
//        Navigator.push(context, MaterialPageRoute(builder: (context) => Google(longitude: longitude, latitude: latitude)));
       
//      }
//      setState(() {
//        email = datauser[0]['email'];
       
      
//      });
//    }
//    return datauser;
//   } 

//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Container(
//           height: 850.0,
//           color: Colors.white,
//           child: new Container(
//               margin: EdgeInsets.only(top:50, left: 50, right: 50, bottom: 250),
//               decoration: new BoxDecoration(
//                 color: Colors.grey,
//                   borderRadius: new BorderRadius.only(
//                       topLeft: const Radius.circular(40.0),
//                       topRight: const Radius.circular(40.0),
//                       bottomLeft: const Radius.circular(40.0),
//                       bottomRight: const Radius.circular(40.0))),
//               child: new Column(
//                 children: <Widget>[
                  
//                     new Padding(
//             padding: EdgeInsets.only(top: 130.0),
//           ),
//           new Text("Sign in",
//           style: TextStyle(
//             fontFamily: "Tangerine",
//               fontWeight: FontWeight.bold,
//               fontSize: 80,
//               color: Colors.black,
//           ),
//           ),
//           new Padding(
//             padding: EdgeInsets.only(top: 30.0),
//           ),
//                  new Container(
//             margin: EdgeInsets.only(left: 20, right: 20),
            
//                   child: TextField(
//               controller: emailinput,
//               decoration: new InputDecoration(
//                 labelText: 'user',
//                 prefixIcon: Icon(Icons.email),
//                 border: new OutlineInputBorder(
//                           borderRadius: new BorderRadius.circular(25.0),
//                           borderSide: new BorderSide(
//                       ),
//                 ),
//               ),
//             ),
//           ),
//            new Padding(
//             padding: EdgeInsets.only(top: 30.0),
//           ),
//           new Container(
//             margin: EdgeInsets.only(left: 20, right: 20),
            
//                   child: TextField(
//               controller: password,
//               decoration: new InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.code),
//                 border: new OutlineInputBorder(
//                           borderRadius: new BorderRadius.circular(25.0),
//                           borderSide: new BorderSide(
//                       ),
//                 ),
//               ),
//             ),
//           ),
//           new Padding(padding: EdgeInsets.only(top: 30)),
//            new ButtonTheme(
//             minWidth: 250.0,
//             height: 50.0,
//             child: new RaisedButton(
                  
//                onPressed: (){
//                  _login();
                 
//                },
//                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
//                color: Colors.white70,
//                child: Text("Sign-up",
//                 style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontFamily: "pacifico",
//                ),
//               ),
//             ),
            
//           ),
//           new Padding(padding: EdgeInsets.only(top: 30)),
//           new Text(msg,
//           style: TextStyle(
//             color: Colors.red,
//             fontFamily: "Tangerine",
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//               )
//             )

//                 ],
//               ),
//             ),
            
//         ),
//       )
//     );
//   }
// }