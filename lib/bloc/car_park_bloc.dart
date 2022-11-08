import 'package:apms_mobile/bloc/repositories/car_park_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'events/car_park_event.dart';
part 'states/car_park_state.dart';

class CarParkBloc extends Bloc<CarParkEvent, CarParkState> {
  CarParkBloc() : super(CarParkInitial()) {
    on<GetCarParkList>(fetchCarParkList());
  }

  fetchCarParkList() async {
    final CarParkRepo repo = CarParkRepo();
    return await repo.fetchCarParkList();
  }
}
