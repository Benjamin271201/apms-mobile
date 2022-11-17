import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Future<Map<String, String>> getHeaderValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token')!;
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };
  }
}
