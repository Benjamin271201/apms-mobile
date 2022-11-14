part of '../booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class ArrivalDateSelected extends BookingEvent {}

class ArrivalTimeSelected extends BookingEvent {}

class SubmitBookingForm extends BookingEvent {
  final String plateNumber;
  final DateTime arrivalTime;

  const SubmitBookingForm(this.plateNumber, this.arrivalTime);
  @override
  List<Object> get props => [plateNumber, arrivalTime];
}
