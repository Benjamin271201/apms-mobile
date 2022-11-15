part of '../booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class ArrivalDateSelected extends BookingEvent {}

class ArrivalTimeSelected extends BookingEvent {}

// At this step, only a confirmation screen will be shown
class SubmitBookingFormStep1 extends BookingEvent {
  final String plateNumber;
  final DateTime arrivalTime;

  const SubmitBookingFormStep1(this.plateNumber, this.arrivalTime);
  @override
  List<Object> get props => [plateNumber, arrivalTime];
}

class SubmitBookingFormStep2 extends BookingEvent {
  final String plateNumber;
  final DateTime arrivalTime;

  const SubmitBookingFormStep2(this.plateNumber, this.arrivalTime);
  @override
  List<Object> get props => [plateNumber, arrivalTime];
}
