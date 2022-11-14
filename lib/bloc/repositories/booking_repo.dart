import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:apms_mobile/models/ticket.dart';

import '../../constants/apis.dart' as apis;
import 'package:http/http.dart' as http;

class BookingApiProvider {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3MTI0ZDM1ZS04MDc2LTRkYzQtYWEwNC0xZmE4NDQ5NjQ2OWYiLCJQaG9uZSI6IjA5MzI3ODE3NDUiLCJyb2xlIjoiQ3VzdG9tZXIiLCJDYXJQYXJrSWQiOiIiLCJuYmYiOjE2NjY3NzUwNjQsImV4cCI6MTY2OTM2NzA2NCwiaWF0IjoxNjY2Nzc1MDY0fQ.7EYE3FUYxmtXMY-WtYWbe6Oz14Nou-ch6JlakHV5Img'
  };
  final _bookingApi = Uri.parse(apis.tickets);

  Future<Ticket> bookParkingSlot() async {
    return Ticket();
  }
}

class BookingRepo {
  final bookingApiProvider = BookingApiProvider();

  Future<Ticket> bookParkingSlot() => bookingApiProvider.bookParkingSlot();
}
