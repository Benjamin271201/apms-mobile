import 'package:apms_mobile/bloc/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'events/login_event.dart';
part 'states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo repo;
  LoginBloc(this.repo) : super(LoginInitial()) {
    on<LoginSumitting>(_submitLogin); 
  }

  _submitLogin(LoginSumitting event, Emitter<LoginState> emit) async {
    emit(Logingin());
    await repo.login(event.phoneNumber, event.password);
    emit(LogedIn());
  }
}
