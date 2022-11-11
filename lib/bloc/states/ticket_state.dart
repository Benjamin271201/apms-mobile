part of '../ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final TicketModel ticket;

  const TicketLoaded(this.ticket);

}

class TicketError extends TicketState {}