import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String phoneNumber;
  final String password;

  const Login(this.phoneNumber, this.password);

  @override
  List<Object?> get props => [];
}
