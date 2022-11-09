import 'package:apms_mobile/bloc/car_park_bloc.dart';
import 'package:apms_mobile/bloc/repositories/car_park_repo.dart';
import 'package:apms_mobile/presentation/components/home/car_park_list.dart';
import 'package:apms_mobile/presentation/components/home/current_location_bar.dart';
import 'package:apms_mobile/presentation/screens/login.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CurrentLocationBar(),
      body: CarParkList(),
    );
  }
}
