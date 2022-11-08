import 'dart:convert';
import 'dart:io';

import 'package:apms_mobile/models/login_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final String _baseUrl = 'http://apms.ga:6001/api';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<bool> login(LoginModel loginModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      // Authenticate
      Response res = await post(Uri.parse(_baseUrl + '/Authentication'),
          headers: headers, body: jsonEncode(loginModel));
      if (res.statusCode == 200) {
        Map body = json.decode(res.body);
        String token = body['data'];
        await pref.setString('token', token);
        return true;
      }
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }
}
