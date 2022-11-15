import 'package:apms_mobile/bloc/booking_bloc.dart';
import 'package:apms_mobile/models/car_park.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation(
      {Key? key,
      required this.plateNumber,
      required this.arrivalTime,
      required this.carPark})
      : super(key: key);
  final CarPark carPark;
  final String plateNumber;
  final DateTime arrivalTime;

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  final BookingBloc bookingBloc = BookingBloc();
  late String plateNumber = plateNumber;
  late DateTime arrivalTime = arrivalTime;
  late CarPark carPark = carPark;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Booking Confirmation")),
        body: _buildBookingConfirmationScreen());
  }

  Widget _buildBookingConfirmationScreen() {
    return Column(children: [
      Text("Name: ${widget.carPark.name}"),
      Text(
          "Address: ${widget.carPark.addressNumber}, ${widget.carPark.street}, ${widget.carPark.district},${widget.carPark.city} "),
      Text("Plate number: ${widget.plateNumber}"),
      Text("Arrival time: ${widget.arrivalTime}"),
    ]);
  }
}
