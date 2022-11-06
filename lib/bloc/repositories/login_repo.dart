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

  Future<void> login(LoginModel loginModel) async {
    print('Loging in----');
    await Future.delayed(const Duration(seconds: 2));
    Response res = await post(Uri.parse(_baseUrl + '/Authentication'),
        headers: headers, body: jsonEncode(loginModel));
    Map body = json.decode(res.body);
    print(body['statusCode']);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('user-info', 'Hello');
    print('Loged In');
  }
}
