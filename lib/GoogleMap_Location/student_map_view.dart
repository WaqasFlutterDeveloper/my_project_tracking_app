import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
class StudentMapViewPage extends StatefulWidget {
  const StudentMapViewPage({Key? key}) : super(key: key);

  @override
  State<StudentMapViewPage> createState() => _StudentMapViewPageState();
}

class _StudentMapViewPageState extends State<StudentMapViewPage> {
  GoogleMapController? mapController;
  final loc.Location location = loc.Location();
  double? currentLat;
  double? currentLont;
  final _markers = <MarkerId, Marker>{};
  @override
  void initState() {
    _animateToUser();
    // TODO: implement initState
    super.initState();
    // populateMarks();
  }

  @override
  void dispose() {
    setState(() {

      mapController?.dispose();

    });

    super.dispose();
  }
  @override

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(29.990059774277483, 73.2629976145002);
  // 29.990059774277483, 73.2629976145002
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  LatLng _lastMapPosition = _center;

  LatLng _upMapPosition = LatLng(29.99228991921171, 73.27817891705024);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  late LatLng currentPostion;
  _animateToUser() async {
    var pos = await location.getLocation();
    setState(() {
      currentPostion = LatLng(pos.latitude!, pos.longitude!);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude!, pos.latitude!),
      zoom: 14.4746,
    )));

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


  // GoogleApiResponse googleApiResponse = GoogleApiResponse();
  void _addMarker(double lat, double lng ,String busNo) async{
    // final Uint8List markerIcon = await getBytesFromAsset('images/b2.png', 100);
    final Uint8List markerIcon = await getBytesFromAsset('images/iubBus.png', 200);
    final id = MarkerId(lat.toString() + lng.toString());
    final _marker = Marker(
      markerId: id,
      onTap: (){

        // print('this is working fine>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        // googleApiResponse.getDistance(
        //     startLatitude: 52.2165157,
        //     startLongitude: 6.9437819,
        //     endLatitude: 52.3546274,
        //     endLongitude: 4.8285838
        // );
        // showDialog(
        //     context: context,
        //     builder: (_) =>  AlertDialog(
        //       title: Text('Info About Current Point:'),
        //       content:Text('Destination :\t Bahawli_Chock \n Orign :\t BWN_Zoo '
        //           '\n duration :\t 4 mints\n distance :\t 600meter'),
        //     )
        // );
      },
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      infoWindow: InfoWindow(title: 'Buss_No:$busNo', snippet: 'IUB POINT'),
    );
    _markers.clear();
    setState(() {
      _markers[id] = _marker;
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.4746,
      )));
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      final data = document.data() as Map<String, dynamic>;
      final GeoPoint point = data['position']['geopoint'];
      final busNo = data['busNo'];
      _addMarker(point.latitude, point.longitude,busNo);
      // print('This is Value of Data <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Data and PopulateMarks');
      // print("Latitude:::${data['busNo']}<<<<<<<<<<<<<<<<");
      // print("Latitude:::${point.latitude}");
      // print("Longititude:::${point.longitude}");
      // _onAddMarkerButtonPressed(point.latitude, point.longitude);
    });
  }
  final firebase = FirebaseFirestore.instance;
  populateMarks(){
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
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    firebase.collection("locations").where("status", isEqualTo: "online").get().then((value){
      if(value.docs.isNotEmpty){
        for(int i = 0; i < value.docs.length; ++i){

          // GeoPoint pos =
          // (value.data()['position']['geopoint'] ?? '';
          print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<value of NAME<<<<<<<<<<<<<<<<<<<<<<>>>>>>>');
          // print('${value.docs[i].data()['name']}');

          // print(value.docs[i].data());
          // initMarker(value.docs[i].data, value.docs[i].data()['name']);
          _updateMarkers(value.docs);
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: populateMarks(),
      builder: (context, snapshot){
        if(snapshot.hasData){
         final value =snapshot.data!.docs;
         print('data of location:$value');
        }
        return GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target:_upMapPosition , zoom: 15),
          markers: Set<Marker>.of(_markers.values),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          trafficEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
        );
      },
    );

  }
}
