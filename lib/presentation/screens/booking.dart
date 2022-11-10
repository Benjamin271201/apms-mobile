import 'package:apms_mobile/constants/apis.dart';
import 'package:apms_mobile/models/car_park.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.carPark}) : super(key: key);
  final CarPark carPark;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late CarPark carPark = widget.carPark;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Booking")),
        body: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_carParkSmallDetailCard(), _carParkBookingForm()],
        )));
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
            TextField(
              decoration: InputDecoration(
                enabled: true,
                labelText: "Plate number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
                decoration: InputDecoration(
                    enabled: true,
                    labelText: "Arrival time",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    suffix: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            onChanged: (date) {},
                            onConfirm: (date) {},
                            currentTime: DateTime.now(),
                            locale: LocaleType.en);
                      },
                    ))),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {}, child: Text("Go to confirmation page "))
          ]),
        ));
  }
}
