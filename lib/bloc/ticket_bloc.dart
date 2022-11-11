import 'package:apms_mobile/models/ticket_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'events/ticket_event.dart';
part 'states/ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
