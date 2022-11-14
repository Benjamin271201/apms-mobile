import 'package:apms_mobile/bloc/repositories/booking_repo.dart';
import 'package:apms_mobile/models/ticket.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'events/booking_event.dart';
part 'states/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SubmitBookingForm>(_submitBookingForm);
  }

  _submitBookingForm(
      SubmitBookingForm event, Emitter<BookingState> emit) async {
    emit(BookingSubmitting());
    // TODO: validation goes here
    final BookingRepo repo = BookingRepo();
    Ticket result = await repo.bookParkingSlot();
    emit(BookingSubmittedSuccessfully());
  }
}
