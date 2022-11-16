// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:apms_mobile/bloc/login_bloc.dart';
import 'package:apms_mobile/bloc/repositories/login_repo.dart';
import 'package:apms_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void checkLogin() async {
    final navigator = Navigator.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? info = pref.getString('token');
    if (info != null) {
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHome(
                    tabIndex: 0,
                  )),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(LoginRepo()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LogedIn) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Login successfully'),
              ));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MyHome(
                      tabIndex: 0,
                    ),
                  ),
                  (route) => false);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Login Screen'),
            ),
            body: _loginForm(),
          ),
        ));
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
      validator: (value) {
        if (value!.length < 9 || value.length > 10) {
          return 'Phone number needs to be from 9 to 10 numbers';
        }
        return null;
      },
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
        if (value!.length < 3) {
          return 'Not enought length';
        }
        return null;
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginSumitting(
                    phoneNumberController.text, passwordController.text));
              }
            },
            child: state is Logingin
                ? const CircularProgressIndicator()
                : const Text('Login'));
      },
    );
  }
}
