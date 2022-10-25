// To parse this JSON data, do
//
//     final qrModel = qrModelFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

Qr qrModelFromJson(String str) => Qr.fromJson(json.decode(str));

String qrModelToJson(Qr data) => json.encode(data.toJson());

class Qr{
  Qr({
    this.checkin,
    this.plate,
    this.carParkId,
  });

  bool? checkin;
  String? plate;
  String? carParkId;

  factory Qr.fromJson(Map<String, dynamic> json) => Qr(
        checkin: json["checkin"],
        plate: json["plate"],
        carParkId: json["carParkId"],
      );

  Map<String, dynamic> toJson() => {
        "checkin": checkin,
        "plate": plate,
        "carParkId": carParkId,
      };
}
