import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentViewLocationPage extends StatefulWidget {

  @override
  State<StudentViewLocationPage> createState() => _StudentViewLocationPageState();
}

class _StudentViewLocationPageState extends State<StudentViewLocationPage> {
  @override
  Widget build(BuildContext context) {
    return ShowMap();
  }
}


class ShowMap extends StatefulWidget {
  const ShowMap({Key? key}) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  double? currentLat;
  double? currentLont;

  @override
  void initState() {
    populateMarks();
    super.initState();
  }
  // final Set<Marker> _markers = {};
  final _markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(29.990059774277483, 73.2629976145002);
  // 29.990059774277483, 73.2629976145002
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  MapType _currentMapType = MapType.normal;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  LatLng _lastMapPosition = _center;

  LatLng _upMapPosition = LatLng(29.99228991921171, 73.27817891705024);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  // void _onAddMarkerButtonPressed(double lat, double lng) {
  //   setState(() {
  //     _markers.add(Marker(
  //       // This marker id can be anything that uniquely identifies each marker.
  //       markerId: MarkerId(_lastMapPosition.toString()),
  //       position: LatLng(lat,lng),
  //       infoWindow: InfoWindow(
  //         title: 'Really cool place',
  //         snippet: '5 Star Rating',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  void _addMarker(double lat, double lng) async{
    final Uint8List markerIcon = await getBytesFromAsset('images/b2.png', 100);
    final id = MarkerId(lat.toString() + lng.toString());
    final _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      _markers[id] = _marker;
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      final data = document.data() as Map<String, dynamic>;
      final GeoPoint point = data['position']['geopoint'];
      _addMarker(point.latitude, point.longitude);
      print('This is Value of Data <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Data and PopulateMarks');
      print("Latitude:::${point.latitude}");
      print("Longititude:::${point.longitude}");
      // _onAddMarkerButtonPressed(point.latitude, point.longitude);
    });
  }

  populateMarks()async{



    // Stream collectionStream = FirebaseFirestore.instance.collection("locations").snapshots();
    // collectionStream.listen((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((document) => print(document.data()));
    //   });

    // final messages= await FirebaseFirestore.instance.collection("locations").get();
    // for(var message in messages.docs) {
    //   print(
    //       'This is Value of Data <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Data and PopulateMarks');
    //   print(message.data());
    // }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("locations").where("status", isEqualTo: "online").get().then((value){
      if(value.docs.isNotEmpty){
        for(int i = 0; i < value.docs.length; ++i){

          // GeoPoint pos =
          // (value.data()['position']['geopoint'] ?? '';
          // print('This is Value of Data <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Data and PopulateMarks');

          // print(value.docs[i].data());
          // initMarker(value.docs[i].data, value.docs[i].data()['name']);
          _updateMarkers(value.docs);
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: _currentMapType,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 16.09,
      ),
      markers: Set<Marker>.of(_markers.values),
      onCameraMove: _onCameraMove,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      trafficEnabled: true,
    );
  }
}

