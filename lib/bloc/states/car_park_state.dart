part of '../car_park_bloc.dart';

abstract class CarParkState extends Equatable {
  const CarParkState();
  
  @override
  List<Object> get props => [];
}

class CarParkInitial extends CarParkState {}
