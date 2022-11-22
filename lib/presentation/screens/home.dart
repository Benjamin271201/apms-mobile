import 'dart:math';

import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/themes/icons.dart';
import 'package:apms_mobile/themes/colors.dart';
import 'package:apms_mobile/models/qr_model.dart';
import 'package:apms_mobile/presentation/screens/qr_scan.dart';
import 'package:apms_mobile/utils/utils.dart';
import 'package:apms_mobile/models/car_park_model.dart';
import 'package:apms_mobile/presentation/screens/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarParkBloc _carParkBloc = CarParkBloc();
  final _debouncer = Debouncer(milliseconds: 1000);
  Placemark? placemark = Placemark();
  CarParkSearchQuery searchQuery = CarParkSearchQuery();
  final List<CarParkModel> carParkList = [];

  @override
  void initState() {
    _carParkBloc.add(const GetUserLocation());
    _carParkBloc.add(GetCarParkList(searchQuery));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: _buildUserLocation()),
        body: Column(children: [
          _buildLocationCard(),
          _buildSearchBar(),
          _buildCarParkList()
        ]));
  }

  Widget _buildLocationCard() {
    return Card();
  }

  Widget _buildUserLocation() {
    return BlocProvider(
        create: (_) => _carParkBloc,
        child: BlocListener<CarParkBloc, CarParkState>(
            listener: (context, state) {
              if (state is CarParkSearchQueryUpdatedSuccessfully) {
                _carParkBloc.add(GetCarParkList(searchQuery));
              }
              if (state is UserLocationFetchedFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
                _carParkBloc.add(GetCarParkList(searchQuery));
              }
              if (state is UserLocationFetchedSuccessfully) {
                var queryData = {
                  "latitude": state.userLocation.latitude,
                  "longitude": state.userLocation.longitude
                };
                placemark = state.userPlacemark[0];
                _carParkBloc
                    .add(UpdateCarParkSearchQuery(searchQuery, queryData));
              }
            },
            child: BlocBuilder<CarParkBloc, CarParkState>(
                builder: ((context, state) => placemark?.street != null
                    ? AppBar(
                        backgroundColor: lightBlue,
                        title: Text(
                          "${placemark?.street}, ${placemark?.country}",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12,
                              color: deepBlue),
                        ),
                        leading: locationOnIcon,
                        actions: <Widget>[_buildQrButton(context)],
                        titleSpacing: -12,
                      )
                    : AppBar(
                        backgroundColor: lightBlue,
                        leading: locationOffIcon,
                        actions: <Widget>[_buildQrButton(context)],
                      )))));
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: (value) => {
          _debouncer.run(() {
            // Search func
            _carParkBloc
                .add(UpdateCarParkSearchQuery(searchQuery, {"name": value}));
          })
        },
      ),
    );
  }

  Widget _buildCarParkList() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: SizedBox(
            height: 450,
            child: DecoratedBox(
                decoration: const BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: lightGrey,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      )
                    ]),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                    width: 400,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: lightBlue),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 170, 5),
                            child: Text("Available Locations",
                                style: TextStyle(
                                    color: deepBlue,
                                    fontWeight: FontWeight.w700)))),
                  ),
                  Scrollbar(
                      child: SizedBox(
                    height: 400,
                    child: BlocProvider(
                      create: (_) => _carParkBloc,
                      child: BlocListener<CarParkBloc, CarParkState>(
                        listener: (context, state) {
                          if (state is CarParkFetchedFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message!),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<CarParkBloc, CarParkState>(
                          builder: (context, state) {
                            if (state is CarParkInitial) {
                              return _buildLoading();
                            } else if (state is CarParkFetching) {
                              return _buildLoading();
                            } else if (state is CarParkFetchedSuccessfully) {
                              return _buildCard(context, state.carParkList);
                            } else if (state is CarParkFetchedFailed) {
                              return Container();
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ))
                ]))));
  }

  Widget _buildCard(BuildContext context, List<CarParkModel> carParkList) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: carParkList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Booking(carPark: carParkList[index]))),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: grey))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    carParkList[index].name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "Address: ${carParkList[index].addressNumber}, ${carParkList[index].street}, ${carParkList[index].district}, ${carParkList[index].city} "),
                  const SizedBox(height: 10),
                  if (carParkList[index].distance != null)
                    Row(children: [
                      distanceIcon,
                      Text(
                          "${carParkList[index].distance!.toStringAsFixed(1)} km")
                    ])
                ],
              ),
            ));
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildQrButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            IconButton(onPressed: () => navigateToQR(context), icon: qrIcon));
  }

  // Navigate to the QR sacanner
  void navigateToQR(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const QRScan()));
  }
}
