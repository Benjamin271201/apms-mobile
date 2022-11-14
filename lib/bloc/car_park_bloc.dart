import 'package:apms_mobile/bloc/repositories/car_park_repo.dart';
import 'package:apms_mobile/models/car_park.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'events/car_park_event.dart';
part 'states/car_park_state.dart';

class CarParkBloc extends Bloc<CarParkEvent, CarParkState> {
  CarParkBloc() : super(CarParkInitial()) {
    on<GetCarParkList>(_fetchCarParkList);
  }

  _fetchCarParkList(GetCarParkList event, Emitter<CarParkState> emit) async {
    emit(CarParkFetching());
    final CarParkRepo repo = CarParkRepo();
    List<CarPark> result =
        await repo.fetchCarParkList(event.latitude, event.longitude);
    emit((CarParkFetchedSuccessfully(result)));
  }
}
