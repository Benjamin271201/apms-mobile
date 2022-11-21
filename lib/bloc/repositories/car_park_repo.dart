import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:apms_mobile/models/car_park_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/paths.dart' as paths;
import 'package:http/http.dart' as http;

class CarParkRepo {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3MTI0ZDM1ZS04MDc2LTRkYzQtYWEwNC0xZmE4NDQ5NjQ2OWYiLCJQaG9uZSI6IjA5MzI3ODE3NDUiLCJyb2xlIjoiQ3VzdG9tZXIiLCJDYXJQYXJrSWQiOiIiLCJuYmYiOjE2NjY3NzUwNjQsImV4cCI6MTY2OTM2NzA2NCwiaWF0IjoxNjY2Nzc1MDY0fQ.7EYE3FUYxmtXMY-WtYWbe6Oz14Nou-ch6JlakHV5Img'
  };

  Future<List<CarParkModel>> fetchCarParkList(
      CarParkSearchQuery searchQuery) async {
    var queryParameters = searchQuery.toJson();
    final getCarParksUri =
        Uri.http(paths.authority, paths.carPark, queryParameters);
    final response = await http.get(getCarParksUri, headers: headers);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> carParkListDynamic = body["data"]["carParks"];
      // Convert to list of carParks
      List<CarParkModel> carParkList = carParkListDynamic
          .map((e) => CarParkModel.fromJson(e))
          .toList()
          .cast<CarParkModel>();
      return carParkList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load list');
    }
  }

  Future<Position> fetchUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
