import'dart:math' as Math;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/ApiGoogleModel.dart';
class GoogleApiResponse{


  // AIzaSyAGiwHViSrYjF2j8Kaq54gWvvKOhufZ5-4
  List<ApiGoogleModel> apiDataList =[];

  Future<List<ApiGoogleModel>> getDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    String Url = 'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${startLatitude},${startLongitude}&origins=${endLatitude},${endLongitude}&key=AIzaSyAGiwHViSrYjF2j8Kaq54gWvvKOhufZ5-4';
    final response = await http.get(
      Uri.parse(Url),);
    dynamic data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        ApiGoogleModel apiResponse =
        ApiGoogleModel(destinationAddresses: i['destination_addresses'] ,
            originAddresses: i['origin_addresses'],
          rows: i['elements']['distance']['text'],
        );
        print('$apiResponse');
        apiDataList.add(ApiGoogleModel.fromJson(i));
        // apiData.add(photos);
      }
      return apiDataList;
    }else
    {
      return apiDataList;
    }

  }



  //This is use to measure liner distance

  // void main()=>print(getDistanceFromLatLonInKm(73.4545,73.4545,83.5454,83.5454));



  double getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lon2-lon1);
    var a =
        Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
                Math.sin(dLon/2) * Math.sin(dLon/2)
    ;
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi/180);
  }

}



