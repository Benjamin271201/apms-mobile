import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/bloc/user_location_bloc.dart';
import 'package:apms_mobile/models/car_park_model.dart';
import 'package:apms_mobile/presentation/screens/booking/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarParkBloc _carParkBloc = CarParkBloc();
  final List<CarParkModel> carParkList = [];
  final UserLocationBloc _userLocationBloc = UserLocationBloc();

  @override
  void initState() {
    _userLocationBloc.add(GetUserLocation());
    _carParkBloc.add(GetCarParkList(null, null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: _buildUserLocation(),
            preferredSize: const Size.fromHeight(50)),
        body: _buildCarParkList());
  }

  Widget _buildUserLocation() {
    return BlocProvider(
        create: (_) => _userLocationBloc,
        child: BlocListener<UserLocationBloc, UserLocationState>(
            listener: (context, state) {
              if (state is UserLocationFetchedFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is UserLocationFetchedSuccessfully) {
                _carParkBloc.add(GetCarParkList(
                    state.userLocation.latitude, state.userLocation.longitude));
              }
            },
            child: BlocBuilder<UserLocationBloc, UserLocationState>(
              builder: ((context, state) => AppBar(
                    title: state is UserLocationFetchedSuccessfully
                        ? Text(state.userPlacemark[0].street! +
                            ", " +
                            state.userPlacemark[0].country!)
                        : Text(""),
                  )),
            )));
  }

  Widget _buildCarParkList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _buildCard(BuildContext context, List<CarParkModel> carParkList) {
    return ListView.builder(
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
}
