part of '../booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingSubmitting extends BookingState {}

class BookingSubmitted extends BookingState {
  final String plateNumber;
  final DateTime arrivalTime;
  const BookingSubmitted(this.plateNumber, this.arrivalTime);
}

class BookingSubmittedSuccessfully extends BookingState {}

class BookingSubmittedFailed extends BookingState {}
