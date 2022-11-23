import 'package:apms_mobile/bloc/booking_bloc.dart';
import 'package:apms_mobile/models/car_park_model.dart';
import 'package:apms_mobile/presentation/screens/booking_confirmation.dart';
import 'package:apms_mobile/themes/colors.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.carPark}) : super(key: key);
  final CarParkModel carPark;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String plateNumber = "";
  late CarParkModel carPark = widget.carPark;
  final BookingBloc _bookingBloc = BookingBloc();
  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController arrivalTimeController = TextEditingController();

  @override
  void initState() {
    _bookingBloc.add(BookingFieldInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: deepBlue),
          title: const Text("Booking", style: TextStyle(color: deepBlue)),
          backgroundColor: lightBlue),
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
                onPressed: () => plateNumberController.text != "" &&
                        arrivalTimeController.text != ""
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingConfirmation(
                                carPark: widget.carPark,
                                plateNumber: plateNumberController.text,
                                arrivalTime: DateFormat("dd-MM-yyyy HH:mm")
                                    .parse(arrivalTimeController.text))))
                    : {},
                child: Text("Go to confirmation page"))
          ]),
        ));
  }

  // Widget _plateNumberField() {
  //   return TypeAheadField(
  //     textFieldConfiguration: TextFieldConfiguration(
  //         autofocus: true,
  //         style: DefaultTextStyle.of(context)
  //             .style
  //             .copyWith(fontStyle: FontStyle.italic),
  //         decoration: InputDecoration(border: OutlineInputBorder())),
  //     suggestionsCallback: (pattern) => {},
  //     itemBuilder: (context, suggestion) {
  //       return ListTile(
  //         leading: Icon(Icons.shopping_cart),
  //         title: Text(suggestion['name']),
  //       );
  //     },
  //     onSuggestionSelected: (suggestion) {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => ProductPage(product: suggestion)));
  //     },
  //   );
  // }

  Widget _plateNumberField() {
    return BlocProvider(
        create: (_) => _bookingBloc,
        child:
            BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
          if (state is UsedPlateNumbersFetchedSuccessfully) {
            return SizedBox(
                width: 400,
                child: Stack(children: [
                  SizedBox(
                      width: 400,
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9-]'))
                        ],
                        controller: plateNumberController,
                        decoration: InputDecoration(
                          enabled: true,
                          labelText: "Plate number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 200, top: 7),
                      child: SizedBox(
                          width: 200,
                          child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: false,
                              ),
                              items: state.plateNumbersList,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                              onChanged: (value) => plateNumberController.text =
                                  value.toString()))),
                  const Padding(
                    padding: EdgeInsets.only(left: 200, top: 15),
                    child: SizedBox(
                        width: 100,
                        height: 30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 248, 248)),
                        )),
                  )
                ]));
          } else {
            return TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-]'))
              ],
              controller: plateNumberController,
              decoration: InputDecoration(
                enabled: true,
                labelText: "Plate number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
            );
          }
        }));
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
            lastDate: DateTime.now().add(const Duration(hours: 24)));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          if (DateTimeField.combine(date, time).compareTo(DateTime.now()) <=
              0) {
            return currentValue;
          }
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}
