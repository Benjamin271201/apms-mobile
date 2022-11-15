import 'package:apms_mobile/bloc/booking_bloc.dart';
import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/constants/apis.dart';
import 'package:apms_mobile/models/car_park.dart';
import 'package:apms_mobile/presentation/screens/booking_confirmation.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.carPark}) : super(key: key);
  final CarPark carPark;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late CarPark carPark = widget.carPark;
  final BookingBloc _bookingBloc = BookingBloc();
  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController arrivalTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking")),
      body: _buildBookingScreen(),
    );
  }

  Widget _buildBookingScreen() {
    return BlocProvider(
        create: (_) => _bookingBloc,
        child: BlocListener<BookingBloc, BookingState>(listener:
            (context, state) {
          if (state is BookingSubmittedFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }, child:
            BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [_carParkSmallDetailCard(), _carParkBookingForm()]);
        })));
  }

  Widget _carParkSmallDetailCard() {
    return Card(
        child: ListTile(
            title: Text(carPark.name),
            subtitle: Text(
                "${carPark.addressNumber} ${carPark.street}, ${carPark.district}, ${carPark.city}")));
  }

  Widget _carParkBookingForm() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          width: 600,
          child: Column(children: [
            _plateNumberField(),
            const SizedBox(height: 10),
            _dateTimePickerField(),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingConfirmation(
                            carPark: widget.carPark,
                            plateNumber: plateNumberController.text,
                            arrivalTime:
                                DateFormat("dd-MM-yyyy HH:mm").parse(arrivalTimeController.text)))),
                child: Text("Go to confirmation page"))
          ]),
        ));
  }

  Widget _plateNumberField() {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-]'))
      ],
      controller: plateNumberController,
      decoration: InputDecoration(
        enabled: true,
        labelText: "Plate number",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _dateTimePickerField() {
    const String _dateTimeFormat = "dd-MM-yyyy HH:mm";
    return DateTimeField(
      controller: arrivalTimeController,
      decoration: InputDecoration(
        enabled: true,
        labelText: "Arrival time",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      format: DateFormat(_dateTimeFormat),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2023));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}
