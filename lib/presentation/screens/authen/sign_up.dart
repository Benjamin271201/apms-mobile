import 'package:apms_mobile/presentation/screens/authen/otp_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP'), elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.blue,),
      body: const OtpScreen(phoneNumber: "+84 932 781 ***",),
    );
  }
}
