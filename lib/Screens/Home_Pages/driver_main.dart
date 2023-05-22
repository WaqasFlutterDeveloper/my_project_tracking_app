import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iub_transport_system/Drawer/emergency_DriverMessage.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../const.dart';
import '../../drawer/change_password.dart';
import '../../drawer/drawer_widget/drawer_elements.dart';
import '../Login_Screen/driver_login_screen.dart';
import '../constants.dart';
class DriverPage extends StatefulWidget {

  @override
  State<DriverPage> createState() => _DriverPageState();
}
class _DriverPageState extends State<DriverPage> {
   final uid = FirebaseAuth.instance.currentUser?.uid;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapController;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  Geoflutterfire geo = Geoflutterfire();
  bool isBool = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription< ConnectivityResult > _connectivitySubscription;




  @override
  initState() {

    _animateToUser();

    // setStatus('online');
    if(isBool == true){
      print('working Fine<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
      _listenLocation(_chosenValue!);
    }

    // Timer(const Duration(seconds: 5),
    //       () =>_listenLocation(),
    // );
    super.initState();


    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
  }



  Future< void > initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  setStatus(String status)async{
    await FirebaseFirestore.instance.collection("locations").doc(uid).update({
      "status":status,
    });
  }

  //This function for live location and store it in FiresBase in GeoPoint:
  Future<void> _listenLocation(String busNo) async {
    location.changeSettings(interval: 100, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print('this is Error<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
      print(onError);
      setStatus('offline');
      _locationSubscription?.cancel();
      _locationSubscription = null;
    }).listen((loc.LocationData currentlocation) async {
      // GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
      setStatus('online');
      var pos = currentlocation;
      GeoFirePoint point =
      geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(
                    currentlocation.longitude!, currentlocation.longitude!),
                tilt: 0,
                zoom: 18.00)));
      }

      return FirebaseFirestore.instance
          .collection('locations')
          .doc(uid)
          .set({
        'position': point.data,
        'locationType': 'live Location',
        'status': 'online',
        'busNo': busNo,
        'uid': uid,
      })
          .then((value) => print('live location adding in firebase<<<<<<<<<'))
          .catchError((Error) => print('This error Hapening<<<<<<<<<: $Error'));
    });
  }
  // = LatLng(29.990059774277483, 73.2629976145002)

  LatLng currentPostion =LatLng(29.990059774277483, 73.2629976145002);
  // LatLng currentPostion;
  _animateToUser() async {
    var pos = await location.getLocation();
    setState(() {
      currentPostion = LatLng(pos.latitude!, pos.longitude!);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude!, pos.latitude!),
      zoom: 17.0,
    )));
  }



  //This function to get permission
  requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //This function stop the live location
  stopListening() {
    _locationSubscription?.cancel();
    setState((){
      setStatus('offline');
      _locationSubscription = null;
    });
    print("stop location<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
  }

  //logout
  logOut() async {
    // Navigator.of(context).pop();
    // auth.signOut();
  }

  //ForeGroundService
  Future<void> startForegroundService() async {
    // ignore: await_only_futures
    // await ForegroundService().start();
  }


  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
  }


  @override
  void dispose() {
    setState(() {
      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
        mapController!.dispose();
        // setStatus('offline');
      }
      _connectivitySubscription.cancel();
    });

    super.dispose();
  }

   List<DropdownMenuItem<String>> get dropdownItems{
     List<DropdownMenuItem<String>> menuItems = [
       DropdownMenuItem(child: Text("BRJ-18"),value: "BRJ-18"),
       DropdownMenuItem(child: Text("BRL-9496"),value: "BRL-9496"),
       DropdownMenuItem(child: Text("BNK-2137"),value: "BNK-2137"),
       DropdownMenuItem(child: Text("BRJ-19"),value: "BRJ-19"),
       DropdownMenuItem(child: Text("BRJ-61"),value: "BRJ-61"),
       DropdownMenuItem(child: Text("BNK-2139"),value: "BNK-2139"),
     ];
     return menuItems;
   }
   String? _chosenValue;
   String? busNo;
   void _showDecline() {
     showDialog(
         context: context,
         builder: (BuildContext context) {
       return AlertDialog(
           title: new Text("Please Enter Bus No"),
           content: Container(
             height: 100,
             width: 200,
             child: Column(
               children: <Widget>[
                 DropdownButtonFormField(
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: kCardColour, width: 2),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       border: OutlineInputBorder(
                         borderSide: BorderSide(color: kCardColour, width: 2),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       filled: true,
                       fillColor: kCardColour,
                       hintText: 'Select Allocation Bus',
                       hintStyle: TextStyle(
                           color: Colors.white
                       ),
                     ),
                     validator: (value) => value == null ? "Select Allocation Bus" : null,
                     dropdownColor: kBackGroundColour,
                     iconEnabledColor: Colors.white,
                     value: _chosenValue,
                     onChanged: (String? newValue) {
                       setState(() {
                         _chosenValue = newValue!;
                         busNo =_chosenValue.toString();
                         print(_chosenValue);
                       });
                     },
                     items: dropdownItems),
               ],
             ),
           ), actions: <Widget>[
       // usually buttons at the bottom of the dialog
       new FlatButton(
       child: new Text("Done"),
           onPressed: (){
             requestPermission();
             _listenLocation(_chosenValue!);
             initConnectivity();
         Navigator.pop(context);
           },
     ),

     ],
     );
   },
   );
}

  funOff(){
    print('off value');
  }

  funOn(){
    print('ON value');setState(() {
      // status1 = val;
      // if(status1 == true){
      //   funOff();
      // }

    });
  }

  bool status1 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColour,
       title:  Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
         FlutterSwitch(
         width: 125.0,
         height: 42.0,
         valueFontSize: 25.0,
         toggleSize: 45.0,
         value: status1,
         borderRadius: 30.0,
         padding: 8.0,
         showOnOff: true,
         onToggle: (val) {
           setState(() {
             status1 = val;

             val == true ?
             {
               // funOff(),
               // funOn(),
             isBool = true,
               _showDecline(),
             // requestPermission(),
             // _listenLocation(),
             // initConnectivity(),



               // funOn(),
               // print('OK<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<')
             }
                 : {
               isBool = true,
               stopListening(),
             };

             // if(val == true){
             //   isBool = true;
             //   requestPermission();
             //   _listenLocation();
             // }else{
             //   isBool = true;
             //   stopListening();
             // }
           });
         },
       ),
           IconButton(
               onPressed: (){
                 if(busNo == null){
                   showDialog(context: context, builder: (_) {
                  return AlertDialog(
                     title: Text('Please First On your location By pressing Switch Button'),
                   );
                  });
                 }else{
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => EmergencyDriverMessage(bus: busNo,)));
                 }
           },
               icon: const Icon(Icons.message))
         ],
       ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
          child: Image.asset('images/drr.png',height: 100.0, width: 100,fit: BoxFit.cover,)),
                  SizedBox(height: 5.0,),

                  Text('Mr. Driver',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                  color: kAppBarColour
              ),

            ),
            // createDrawerItem(icon: Icons.location_on,text: 'Start Sharing Location',
            //     onTap: () {
            //
            //         print('live location');
            //         isBool = true;
            //         requestPermission();
            //         _listenLocation();
            //
            //     }),
            // createDrawerItem(icon: Icons.location_off,
            //     text: 'Stop Sharing Location',
            //     onTap: () {
            //
            //     print('stop location');
            //     isBool = true;
            //     stopListening();
            //
            //
            //     }),

            createDrawerItem(icon: Icons.password_rounded,text: 'Change Password',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                }),

            Divider(),
            createDrawerItem(icon: Icons.logout,text: 'LogOut',
                onTap: ()async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DriverLoginScreen()));
                }),
          ],
        ),
      ),
        // Center(child: Text('Map Loding...',style: TextStyle(fontSize: 30.0),),),
      body: GoogleMap(
        // markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
            target:currentPostion, zoom: 10),
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        // trafficEnabled: true,
        // markers:{
        //   Marker(
        //     markerId: MarkerId('current_Postion'),
        //     infoWindow: InfoWindow(title: 'Current Position'),
        //     position: currentPostion!,
        //     icon: BitmapDescriptor.defaultMarkerWithHue(
        //       BitmapDescriptor.hueGreen,
        //     ),
        //   ),
        // }

      ),
      );
  }
}



