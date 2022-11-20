import 'package:apms_mobile/bloc/repositories/car_park_repo.dart';
import 'package:apms_mobile/models/car_park_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'events/car_park_event.dart';
part 'states/car_park_state.dart';

final CarParkRepo repo = CarParkRepo();

class CarParkBloc extends Bloc<CarParkEvent, CarParkState> {
  CarParkBloc() : super(CarParkInitial()) {
    on<GetCarParkList>(_fetchCarParkList);
    on<GetUserLocation>(_fetchUserLocation);
  }

  _fetchCarParkList(GetCarParkList event, Emitter<CarParkState> emit) async {
    emit(CarParkFetching());
    List<CarParkModel> result = await repo.fetchCarParkList(event.searchQuery);
    emit((CarParkFetchedSuccessfully(result)));
  }

  _fetchUserLocation(GetUserLocation event, Emitter<CarParkState> emit) async {
    Position _userLocation;
    List<Placemark> _userPlacemark;

    emit(UserLocationFetching());
    _userLocation = await repo.fetchUserLocation();
    _userPlacemark = await placemarkFromCoordinates(
        _userLocation.latitude, _userLocation.longitude);

    emit(UserLocationFetchedSuccessfully(_userLocation, _userPlacemark));
  }
}
