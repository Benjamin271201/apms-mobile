import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:apms_mobile/models/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/paths.dart' as paths;
import '../../constants/apis.dart' as apis;
import 'package:http/http.dart' as http;

import '../../models/ticket_model.dart';

class BookingApiProvider {
  final _bookingApi = Uri.parse(paths.tickets);

  Future<TicketPreview> fectchTicketPreview(
      String plateNumber, DateTime arrivalTime, String carParkId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token')!;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };
    final getTicketPreview =
        Uri.http(paths.authority, "${paths.tickets}/preview");
    var body = json.encode({
      "plateNumber": plateNumber,
      "arrivalTime": arrivalTime.toIso8601String(),
      "carParkId": carParkId
    });
    final response =
        await http.post(getTicketPreview, headers: headers, body: body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      Map<String, dynamic> body = jsonDecode(response.body);
      TicketPreview ticketPreview = TicketPreview.fromJson(body);
      return ticketPreview;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load list');
    }
  }
}

class BookingRepo {
  final bookingApiProvider = BookingApiProvider();

  Future<TicketPreview> bookParkingSlot(
          String plateNumber, DateTime arrivalTime, String carParkId) =>
      bookingApiProvider.fectchTicketPreview(
          plateNumber, arrivalTime, carParkId);
}
