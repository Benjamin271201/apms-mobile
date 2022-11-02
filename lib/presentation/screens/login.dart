import 'package:apms_mobile/bloc/login_bloc.dart';
import 'package:apms_mobile/bloc/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(RepositoryProvider.of(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_phoneNumberField(), _passwordField(), _loginButton()],
        ),
      ),
    );
  }

  Widget _phoneNumberField() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      controller: phoneNumberController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Phone Number',
      ),
      validator: (value) => null,
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
      validator: (value) {
        if (value!.length < 9) {
          return 'Not enought length';
        }
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state is Logingin
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSumitting(
                        phoneNumberController.text, passwordController.text));
                  }
                },
                child: const Text('Login'));
      },
    );
  }
}
