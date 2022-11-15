import 'package:apms_mobile/bloc/repositories/booking_repo.dart';
import 'package:apms_mobile/models/ticket.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'events/booking_event.dart';
part 'states/booking_state.dart';

final BookingRepo repo = BookingRepo();

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<SubmitBookingFormStep1>(_fetchBookingConfirmationScreen);
    on<SubmitBookingFormStep2>(_submitBookingForm);
  }

  _fetchBookingConfirmationScreen(
      SubmitBookingFormStep1 event, Emitter<BookingState> emit) {
    emit(BookingPreviewFetching());
    try {
      
    } catch (e) {
      emit(BookingPreviewFetchedFailed());
    }
    emit(BookingPreviewFetchedSuccessfully());
  }

  _submitBookingForm(
      SubmitBookingFormStep2 event, Emitter<BookingState> emit) async {
    emit(BookingSubmitting());
    // TODO: validation goes here
    Ticket result = await repo.bookParkingSlot();
    emit(BookingSubmittedSuccessfully(result));
  }
}
