part of '../ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {

  Future<TicketModel> getTicketList(TicketRepo repo, String from, String to,
      String plateNumber, String statusValue, int pageIndex) async {
    TicketModel? ticketModel =
        await repo.getHistory(from, to, plateNumber, statusValue, pageIndex);
    return ticketModel!;
  }
}

class TicketLoaded extends TicketState {
  final TicketModel ticket;

  const TicketLoaded(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class TicketLoadedMore extends TicketState {
  final TicketModel ticket;

  const TicketLoadedMore(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class TicketError extends TicketState {
  final String? message;

  const TicketError(this.message);
}

class TicketDateChanged extends TicketState{}

class TicketCanceled extends TicketState{}

class TicketCanceling extends TicketState{}
