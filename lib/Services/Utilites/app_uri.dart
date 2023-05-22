// import 'package:dio/dio.dart';
//
// Dio _dio = new Dio();
//
// Response response = await _dio.get(
// "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$dlatitude,$dlongitude&origins=$slatitude,$slongitude&key=YOUR_KEY_HERE");
// print(response.data);



class AppUri{
  static  const baseUri = 'https://disease.sh/v3/covid-19/';

  static  const worldStateApi= baseUri + 'all';

  static  const countriesListApi = baseUri + 'countries';
}