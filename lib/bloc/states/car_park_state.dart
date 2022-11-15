part of '../car_park_bloc.dart';

abstract class CarParkState extends Equatable {
  const CarParkState();

  @override
  List<Object> get props => [];
}

class CarParkInitial extends CarParkState {}

class CarParkFetching extends CarParkState {}

class CarParkFetchedSuccessfully extends CarParkState {
  final List<CarParkModel> carParkList;
  const CarParkFetchedSuccessfully(this.carParkList);
}

class CarParkFetchedFailed extends CarParkState {
  final String? message;
  const CarParkFetchedFailed(this.message);
}
