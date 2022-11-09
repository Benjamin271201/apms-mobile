import 'package:apms_mobile/bloc/repositories/user_location_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'events/user_location_event.dart';
part 'states/user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  final UserLocationProvider repo;
  UserLocationBloc(this.repo) : super(UserLocationInitial()) {
    on<GetUserLocation>(_fetchUserLocation);
  }

  _fetchUserLocation(
      GetUserLocation event, Emitter<UserLocationState> emit) async {
    Position _userLocation;

    emit(UserLocationFetching());
    _userLocation = await repo.fetchUserLocation();
    print(_userLocation);

    emit(UserLocationFetchedSuccessfully(_userLocation));
  }
}
