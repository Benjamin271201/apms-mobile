import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:apms_mobile/models/car_park.dart';
import '../../constants/paths.dart' as paths;
import 'package:http/http.dart' as http;

class CarParkApiProvider {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3MTI0ZDM1ZS04MDc2LTRkYzQtYWEwNC0xZmE4NDQ5NjQ2OWYiLCJQaG9uZSI6IjA5MzI3ODE3NDUiLCJyb2xlIjoiQ3VzdG9tZXIiLCJDYXJQYXJrSWQiOiIiLCJuYmYiOjE2NjY3NzUwNjQsImV4cCI6MTY2OTM2NzA2NCwiaWF0IjoxNjY2Nzc1MDY0fQ.7EYE3FUYxmtXMY-WtYWbe6Oz14Nou-ch6JlakHV5Img'
  };

  Future<List<CarPark>> fetchCarParkList(
      double? latitude, double? longitude) async {
    var queryParameters = {
      "latitude": latitude == null ? "" : latitude.toString(),
      "longitude": longitude == null ? "" : longitude.toString()
    };
    final _getCarParksUri =
        Uri.http(paths.authority, paths.carPark, queryParameters);
    final response = await http.get(_getCarParksUri, headers: headers);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> carParkListDynamic = body["data"]["carParks"];
      // Convert to list of carParks
      List<CarPark> carParkList = carParkListDynamic
          .map((e) => CarPark.fromJson(e))
          .toList()
          .cast<CarPark>();
      return carParkList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load list');
    }
  }
}

class CarParkRepo {
  final carParkApiProvider = CarParkApiProvider();

  Future<List<CarPark>> fetchCarParkList(double? latitude, double? longitude) =>
      carParkApiProvider.fetchCarParkList(latitude, longitude);
}
