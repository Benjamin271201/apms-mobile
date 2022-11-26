import 'dart:convert';

import 'package:apms_mobile/exceptions/exception.dart';
import 'package:apms_mobile/presentation/screens/profile/profile.dart';
import 'package:apms_mobile/utils/utils.dart';
import 'package:http/http.dart';

import '../../constants/paths.dart' as paths;
import 'package:http/http.dart' as http;

class ProfileRepo {
  Future<Profile> getProfilePersonalInformation() async {
    final uri = Uri.http(paths.authority, paths.profiles);
    final headers = await Utils().getHeaderValues();

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Profile profile = body["data"];
      return profile;
    } else {
      throw HttpException("Unable to fetch profile information!");
    }
  }
}
