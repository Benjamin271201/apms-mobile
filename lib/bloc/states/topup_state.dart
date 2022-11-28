part of '../topup_bloc.dart';

abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {}

class ExchangeRateFetching extends TopupState {}

class ExchangeRateFetchedFailed extends TopupState {}

class ExchangeRateFetchedSuccessfully extends TopupState {
  final int exchangeRate;
  const ExchangeRateFetchedSuccessfully(this.exchangeRate);
}
