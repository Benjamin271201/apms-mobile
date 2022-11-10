part of '../user_location_bloc.dart';

abstract class UserLocationState extends Equatable {
  const UserLocationState();

  @override
  List<Object> get props => [];
}

class UserLocationInitial extends UserLocationState {}

class UserLocationFetching extends UserLocationState {}

class UserLocationFetchedSuccessfully extends UserLocationState {
  final Position userLocation;
  final List<Placemark> userPlacemark;

  const UserLocationFetchedSuccessfully(this.userLocation, this.userPlacemark);
}

class UserLocationFetchedFailed extends UserLocationState {}