import 'package:apms_mobile/bloc/booking_bloc.dart';
import 'package:apms_mobile/models/car_park_model.dart';
import 'package:apms_mobile/models/ticket_model.dart';
import 'package:apms_mobile/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation(
      {Key? key,
      required this.plateNumber,
      required this.arrivalTime,
      required this.carPark})
      : super(key: key);
  final CarParkModel carPark;
  final String plateNumber;
  final DateTime arrivalTime;

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  final BookingBloc _bookingBloc = BookingBloc();
  late String plateNumber = plateNumber;
  late DateTime arrivalTime = arrivalTime;
  late CarParkModel carPark = carPark;

  @override
  void initState() {
    _bookingBloc.add(SubmitBookingFormStep1(
        widget.plateNumber, widget.arrivalTime, widget.carPark.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Booking Confirmation")),
        body: _buildBookingConfirmationScreen());
  }

  Widget _buildBookingConfirmationScreen() {
    return BlocProvider(
        create: (context) => _bookingBloc,
        child: BlocListener<BookingBloc, BookingState>(
            listener: (context, state) => {
                  if (state is BookingPreviewFetchedFailed)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      )),
                    }
                  else if (state is BookingSubmittedSuccessfully)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(state.message),
                        ),
                      ),
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const Home()))
                    }
                  else if (state is BookingSubmittedFailed)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      ),
                      Navigator.pop(context)
                    }
                },
            child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
              if (state is BookingPreviewFetching) {
                return _buildLoading();
              } else if (state is BookingPreviewFetchedSuccessfully) {
                return _buildConfirmationCard(context, state.ticketPreview);
              } else {
                return Container();
              }
            })));

    // return BlocListener<BookingBloc, BookingState>{
    //   (children: [

    // ]);
  }

  Widget _buildConfirmationCard(
      BuildContext context, TicketPreview ticketPreview) {
    return Card(
        child: SizedBox(
            height: 300,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${ticketPreview.carParkName}"),
                  const SizedBox(height: 10),
                  Text("Address: ${ticketPreview.carParkAddress}"),
                  const SizedBox(height: 10),
                  Text("Plate number: ${ticketPreview.plateNumber}"),
                  const SizedBox(height: 10),
                  Text("Arrival time: ${ticketPreview.arriveTime}"),
                  const SizedBox(height: 10),
                  Text("Price: ${ticketPreview.priceTable.toString()}"),
                  const SizedBox(height: 30),
                  Row(children: [
                    Text("Reservation fee: ${ticketPreview.reservationFee}"),
                    const SizedBox(width: 50),
                    ElevatedButton(
                        onPressed: () => {
                              _bookingBloc.add(SubmitBookingFormStep2(
                                  widget.plateNumber,
                                  widget.arrivalTime,
                                  widget.carPark.id))
                            },
                        child: Text("Pay")),
                  ])
                ],
              ),
            )));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
