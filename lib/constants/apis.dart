import 'dart:io';

const baseUrl = "http://18.136.151.97:6001/api";

Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

const carPark = "$baseUrl/carparks";
const login = "$baseUrl/Authentication/customer";
const history = "$baseUrl/Tickets";
const tickets = "$baseUrl/tickets";
