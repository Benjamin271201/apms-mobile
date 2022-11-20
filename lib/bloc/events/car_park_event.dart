part of '../car_park_bloc.dart';

abstract class CarParkEvent extends Equatable {
  const CarParkEvent();

  @override
  List<Object> get props => [];
}

class GetCarParkList extends CarParkEvent {
  final CarParkSearchQuery searchQuery;

  const GetCarParkList(this.searchQuery);

  @override
  List<Object> get props => [];
}

class UpdateCarParkSearchQuery extends CarParkEvent {
  final CarParkSearchQuery searchQuery;

  const UpdateCarParkSearchQuery(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}

class GetUserLocation extends CarParkEvent {}
