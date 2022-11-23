// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:apms_mobile/bloc/login_bloc.dart';
import 'package:apms_mobile/bloc/repositories/login_repo.dart';
import 'package:apms_mobile/main.dart';
import 'package:apms_mobile/presentation/screens/authen/forgot_password.dart';
import 'package:apms_mobile/presentation/screens/authen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          body: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _buildHeader(),
                    _loginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 60),
      child: Column(
        children: [
          Image.asset(
            './assets/images/logo.png',
            scale: 2,
          ),
          const SizedBox(
            height: 18,
          ),
          const Text(
            'Welcome back!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Times',
            ),
          ),
        ],
      ),
    );
  }

//Form
  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _phoneNumberField(),
            const SizedBox(
              height: 26,
            ),
            _passwordField(),
            const SizedBox(
              height: 16,
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

// Phone number input field
  Widget _phoneNumberField() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      controller: phoneNumberController,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: 'Enter your phone number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        suffixIcon: const Icon(
          Icons.phone_iphone_rounded,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black38),
          gapPadding: 10,
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value!.length < 9 || value.length > 10) {
          return 'Phone number needs to be from 9 to 10 numbers';
        }
        return null;
      },
    );
  }

// Paasword input field
  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      obscuringCharacter: "*",
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        suffixIcon: const Icon(
          Icons.lock_outline_rounded,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.black38),
          gapPadding: 10,
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (value) {
        if (value!.length < 3) {
          return 'Password needs to be from 3 to 6 characters';
        }
        return null;
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const ForgotPassword()),
              ),
            ),
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Forgot password',
                textAlign: TextAlign.end,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: const Color.fromRGBO(49, 147, 225, 1),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSumitting(
                      phoneNumberController.text, passwordController.text));
                }
              },
              child: state is Logingin
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "times",
                          fontSize: 18),
                    ),
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 14, color: Color.fromRGBO(49, 147, 225, 1)),
                ),
              )
            ],
          )
        ]);
      },
    );
  }
}
