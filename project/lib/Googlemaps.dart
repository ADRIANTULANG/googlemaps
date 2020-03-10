import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';



class Google extends StatefulWidget {
  Google({Key key, this.title, this.address, this.latitude, this.longitude, this.email}) : super(key: key);
  final String title;
  final String address;
  final String latitude;
  final String longitude;
  final String email;

  

  @override
  _GoogleState createState() => _GoogleState(longitude: longitude, latitude: latitude);
}

class _GoogleState extends State<Google> {
_GoogleState({this.latitude, this.longitude});
 String latitude; 
 String longitude;


  


  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];



  Future<void> goToLocation() async {

     print(latitude);
    print(longitude);

      var lat = double.parse(latitude);
      var long = double.parse(longitude);

      
    
     final CameraPosition usernewplace = new CameraPosition(
    target: LatLng(lat,long),
    bearing: 150.8334901395799,
    zoom: 10.151926040649414,
    tilt: 30.440717697143555,
  );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(usernewplace));

    setState(() {
      allMarkers.add(Marker(
      markerId: MarkerId('MYMARKERS'),
      draggable: false,
      position: LatLng(lat,long),
    ));

    GoogleMap(
      initialCameraPosition: usernewplace,
      markers: Set.from(allMarkers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        },
      );
    
    });

  }

  static final CameraPosition _kGooglePlex = new CameraPosition(
    target: LatLng(8.497437, 124.656978),
    bearing: 150.8334901395799,
    zoom: 18.151926040649414,
    tilt: 30.440717697143555,
  );

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('MYMARKERS'),
      draggable: false,
      position: LatLng(8.497437, 124.656978),
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: _kGooglePlex,
      markers: Set.from(allMarkers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToLocation,
       label: Text("Goto Location of the car"),
        icon: Icon(Icons.directions_car),
        ),
    );
  }
}


