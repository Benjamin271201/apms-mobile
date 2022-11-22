import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/constants/icons.dart';
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
                        title: Text(
                          "${placemark?.street}, ${placemark?.country}",
                          style: TextStyle(fontFamily: "Roboto", fontSize: 12),
                        ),
                        leading: locationOnIcon,
                        actions: <Widget>[_buildQrButton(context)],
                        titleSpacing: -12,
                      )
                    : AppBar(
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
            height: 400,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
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
            )));
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
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 196, 193, 193),
                      width: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Name: ${carParkList[index].name}".toUpperCase(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Address: ${carParkList[index].addressNumber}, ${carParkList[index].street}, ${carParkList[index].district},${carParkList[index].city} "
                        .toUpperCase(),
                  ),
                  const SizedBox(height: 10),
                  if (carParkList[index].distance != null)
                    Text(
                      "Distance: ${carParkList[index].distance!.toStringAsFixed(1)} km"
                          .toUpperCase(),
                    )
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
