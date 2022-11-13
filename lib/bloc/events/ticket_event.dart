part of '../ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTicketList extends TicketEvent {
  final String from;
  final String to;
  final String plateNumber;
  final String statusValue;
  final int pageIndex;

  const GetTicketList(this.from, this.to, this.plateNumber, this.statusValue, this.pageIndex);

  @override
  List<Object> get props => [from, to, plateNumber, statusValue, pageIndex];
}
