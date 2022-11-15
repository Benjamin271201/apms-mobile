import 'package:apms_mobile/bloc/repositories/booking_repo.dart';
import 'package:apms_mobile/models/ticket_model.dart';
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
      SubmitBookingFormStep1 event, Emitter<BookingState> emit) async {
    emit(BookingPreviewFetching());
    try {
      TicketPreview ticketPreview = await repo.bookingApiProvider
          .fectchTicketPreview(
              event.plateNumber, event.arrivalTime, event.carParkId);
      emit(BookingPreviewFetchedSuccessfully(ticketPreview));
    } catch (e) {
      emit(BookingPreviewFetchedFailed());
    }
  }

  _submitBookingForm(
      SubmitBookingFormStep2 event, Emitter<BookingState> emit) async {
    emit(BookingSubmitting());
    // TODO: validation goes here
    // Ticket result = await repo.bookParkingSlot(event.plateNumber, event.arrivalTime, event.carParkId);
    // emit(BookingSubmittedSuccessfully(result));
  }
}
