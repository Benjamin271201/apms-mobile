import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({Key? key, this.phoneNumber = ''}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FocusNode pin1FocusNode = FocusNode();
  FocusNode pin2FocusNode = FocusNode();
  FocusNode pin3FocusNode = FocusNode();
  FocusNode pin4FocusNode = FocusNode();
  int timeleft = 30;
  Map otp = {};

  @override
  void initState() {
    if (mounted) {
      startCountDown();
    }
    super.initState();
  }

  @override
  void dispose() {
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

// Timer
  void startCountDown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeleft > 0) {
          setState(() {
            timeleft--;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

// Go to next input
  void nextField(
      {required String value,
      required int index,
      required FocusNode focusNode}) {
    otp[index] = value;
    if (otp.length < 4) {
      focusNode.requestFocus();
    } else {
      String value = "";
      for (var element in otp.values) {
        value = value + element;
      }
      log(value);
      log(otp.toString());
      focusNode.unfocus();
    }
  }

// Return to previous input
  void previousField({required int index, required FocusNode focusNode}) {
    otp.remove(index);
    focusNode.requestFocus();
    log(otp.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
        child: Column(
          children: [
            const Text(
              'OTP Verification',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'times',
                  fontSize: 36),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'We sent your code to ${widget.phoneNumber}',
              style: const TextStyle(
                  fontFamily: 'times', fontSize: 18, color: Colors.black26),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Get new code in '),
                Text('00:${timeleft.toString().length > 1 ? timeleft.toString() : "0$timeleft"}',
                    style: const TextStyle(
                        color: Color.fromRGBO(49, 147, 225, 1))),
                TextButton(
                  onPressed: () {
                    if (timeleft == 0) {
                      setState(() {
                        timeleft = 30;
                        startCountDown();
                        log(timeleft.toString());
                      });
                    } else {}
                  },
                  child: Text(
                    'Re-send',
                    style: TextStyle(
                        color: timeleft == 0
                            ? const Color.fromRGBO(49, 147, 225, 1)
                            : Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            _buildInput(),
          ],
        ),
      ),
    );
  }

//Input and submit button
  Form _buildInput() {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70,
                child: TextFormField(
                  focusNode: pin1FocusNode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: inputDecoration(),
                      border: inputDecoration()),
                  onChanged: (value) {
                    if (value.length == 1) {
                      nextField(
                          value: value, index: 0, focusNode: pin2FocusNode);
                    } else {
                      previousField(index: 0, focusNode: pin1FocusNode);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: inputDecoration(),
                      border: inputDecoration()),
                  onChanged: (value) {
                    if (value.length == 1) {
                      nextField(
                          value: value, index: 1, focusNode: pin3FocusNode);
                    } else {
                      previousField(index: 1, focusNode: pin1FocusNode);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: inputDecoration(),
                      border: inputDecoration()),
                  onChanged: (value) {
                    if (value.length == 1) {
                      nextField(
                          value: value, index: 2, focusNode: pin4FocusNode);
                    } else {
                      previousField(index: 2, focusNode: pin2FocusNode);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: inputDecoration(),
                      border: inputDecoration()),
                  onChanged: (value) {
                    if (value.length == 1) {
                      nextField(
                          value: value, index: 3, focusNode: pin4FocusNode);
                    } else {
                      previousField(index: 3, focusNode: pin3FocusNode);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
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
              onPressed: () {},
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white, fontFamily: "times", fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder inputDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.black38),
    );
  }
}
