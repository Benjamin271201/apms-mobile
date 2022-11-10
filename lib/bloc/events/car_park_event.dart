part of '../car_park_bloc.dart';

abstract class CarParkEvent extends Equatable {
  const CarParkEvent();

  @override
  List<Object> get props => [];
}

class GetCarParkList extends CarParkEvent {}
