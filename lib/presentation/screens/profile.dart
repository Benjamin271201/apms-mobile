import 'package:apms_mobile/presentation/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_logOutButton()],
        ),
      ),
    );
  }

  Widget _logOutButton() {
    return OutlinedButton.icon(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.clear();
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.login),
        label: const Text('Log out'));
  }
}
