import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/bloc/repositories/car_park_repo.dart';
import 'package:apms_mobile/models/car_park.dart';
import 'package:apms_mobile/presentation/screens/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarParkList extends StatefulWidget {
  const CarParkList({Key? key}) : super(key: key);

  @override
  State<CarParkList> createState() => _CarParkListState();
}

class _CarParkListState extends State<CarParkList> {
  final CarParkBloc _carParkBloc = CarParkBloc(CarParkRepo());
  final List<CarPark> carParkList = [];

  @override
  void initState() {
    // _carParkBloc.add(getUserLocation());
    _carParkBloc.add(GetCarParkList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCarParkList(),
    );
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

  Widget _buildCard(BuildContext context, List<CarPark> carParkList) {
    return ListView.builder(
      itemCount: carParkList.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Booking(carPark: carParkList[index]))),
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
                ],
              ),
            ));
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
