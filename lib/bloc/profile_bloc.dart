import 'package:apms_mobile/bloc/repositories/profile_repo.dart';
import 'package:apms_mobile/presentation/screens/profile/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'events/profile_event.dart';
part 'states/profile_state.dart';

final repo = ProfileRepo();
final token = SharedPreferences.getInstance();

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileInformation>(_fetchProfileInformation);
  }

  _fetchProfileInformation(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      print(123);
      emit(ProfileFetching());
      print(123);
      Profile result = await repo.getProfilePersonalInformation();
      emit(ProfileFetchedSuccessfully(result));
    } catch (e) {
      emit(ProfileFetchedFailed());
    }
  }
}
