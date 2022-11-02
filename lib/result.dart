import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'models/qr_model.dart';

class Result extends StatefulWidget {
  const Result({Key? key, required this.qr}) : super(key: key);

  final Qr qr;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<String> dataFuture;
  static const String baseUrl = 'http://apms.ga:6001/api';
  @override
  void initState() {
    super.initState();
    dataFuture = processQr(widget.qr);
  }

  Future<String> processQr(Qr qr) async {
    Object body;
    String jsonString;
    Uri uri;
    Response result;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI3MTI0ZDM1ZS04MDc2LTRkYzQtYWEwNC0xZmE4NDQ5NjQ2OWYiLCJQaG9uZSI6IjA5MzI3ODE3NDUiLCJyb2xlIjoiQ3VzdG9tZXIiLCJDYXJQYXJrSWQiOiIiLCJuYmYiOjE2NjY3NzUwNjQsImV4cCI6MTY2OTM2NzA2NCwiaWF0IjoxNjY2Nzc1MDY0fQ.7EYE3FUYxmtXMY-WtYWbe6Oz14Nou-ch6JlakHV5Img'
    };
    if (!qr.checkin!) {
      body = {
        "plateNumber": qr.plate,
        "plateNumberImageUrl": qr.firebaseUrl,
        "carParkId": qr.carParkId
      };
      jsonString = json.encode(body);
      uri = Uri.parse(baseUrl + '/check-in/create-ticket');
      result = await post(uri, headers: headers, body: jsonString);
      final reBdy = json.decode(result.body);
      return 'Check In Succesfully';
    } else {
      Map<String, String> body = {
        "plateNumber": qr.plate!,
        "picOutUrl": qr.firebaseUrl!,
        "carParkId": qr.carParkId!
      };
      jsonString = json.encode(body);
      uri = Uri.parse(baseUrl + '/check-out').replace(queryParameters: body);
      result = await put(uri, headers: headers, body: jsonString);
      final reBdy = json.decode(result.body);
      return 'Check Out Successfully';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
          future: dataFuture,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              String data = snapshot.data!;

              return Text(data);
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
