import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:apms_mobile/models/car_park.dart';
import 'package:http/http.dart' as http;

class CarParkApiProvider {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3MTI0ZDM1ZS04MDc2LTRkYzQtYWEwNC0xZmE4NDQ5NjQ2OWYiLCJQaG9uZSI6IjA5MzI3ODE3NDUiLCJyb2xlIjoiQ3VzdG9tZXIiLCJDYXJQYXJrSWQiOiIiLCJuYmYiOjE2NjY3NzUwNjQsImV4cCI6MTY2OTM2NzA2NCwiaWF0IjoxNjY2Nzc1MDY0fQ.7EYE3FUYxmtXMY-WtYWbe6Oz14Nou-ch6JlakHV5Img'
  };
  final _carParkApi =
      new Uri.dataFromString("http://18.136.151.97:6001/api/carparks");

  Future<CarPark> fetchCarParkList() async {
    final response = await http.get(_carParkApi, headers: headers);
    print(CarPark.fromJson(jsonDecode(response.body)));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return CarPark.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load list');
    }
  }
}

class CarParkRepo {
  final carParkApiProvider = CarParkApiProvider();

  Future<CarPark> fetchCarParkList() => carParkApiProvider.fetchCarParkList();
}
