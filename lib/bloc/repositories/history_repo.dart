import 'dart:convert';
import 'dart:io';

import 'package:apms_mobile/models/ticket_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../constants/apis.dart' as apis;

class HistoryRepo {
  Future<TicketModel?> getHistory(String from, String to, String plateNumber,
      String statusValue, int pageIndex) async {
    //Get acount id
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token')!;
    String accountId = JwtDecoder.decode(token)['nameid'];
    // Map of status
    Map<int, String> statusList = {
      0: "Booking",
      1: "Parking",
      2: "Done",
      -1: "Cancel"
    };
    // Get key of status based on value
    int status =
        statusList.keys.firstWhere((e) => statusList[e] == statusValue);
    //Request body
    Map<String, dynamic> request = {
      "accountId": accountId,
      "from": from,
      "to": to,
      "plateNumber": plateNumber,
      "status": status,
      "pageSize": 10,
      "pageIndex": pageIndex,
      "includeCarPark": true,
      "includePriceTable": false
    };
    final Uri url = Uri.parse(apis.history).replace(queryParameters: request);
    Map<String, String> headers = apis.headers;
    headers[HttpHeaders.authorizationHeader] = token;
    Response res = await get(url, headers: headers);
    if (res.statusCode == 200) {
      Map body = json.decode(res.body);
      String data = body['data'];
      final TicketModel ticket = ticketModelFromJson(data);
      return ticket;
    }
    return null;
  }
}
