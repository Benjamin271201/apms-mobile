import 'package:apms_mobile/bloc/repositories/user_location_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'events/user_location_event.dart';
part 'states/user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  UserLocationBloc() : super(UserLocationInitial()) {
    on<GetUserLocation>(_fetchUserLocation);
  }

  _fetchUserLocation(
      GetUserLocation event, Emitter<UserLocationState> emit) async {
    Position _userLocation;
    List<Placemark> _userPlacemark;
    final UserLocationProvider repo = UserLocationProvider();

    emit(UserLocationFetching());
    _userLocation = await repo.fetchUserLocation();
    _userPlacemark = await placemarkFromCoordinates(
        _userLocation.latitude, _userLocation.longitude);

    emit(UserLocationFetchedSuccessfully(_userLocation, _userPlacemark));
  }
}
