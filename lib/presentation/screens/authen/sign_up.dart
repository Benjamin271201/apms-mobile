import 'package:apms_mobile/presentation/screens/authen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP'), elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.blue,),
      body: OtpScreen(phoneNumber: "+84 932 781 ***",),
    );
  }
}
