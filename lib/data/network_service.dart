import 'dart:convert';

import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://18.136.151.97:6001/api";

  Future<List<dynamic>> getCarParkList() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/carparks"));
      return jsonDecode(response.body) as List;
    } catch (e) {
      throw Error();
    }
  }
}