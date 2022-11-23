import 'package:apms_mobile/presentation/screens/authen/sign_in.dart';
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
    final navigator = Navigator.of(context, rootNavigator: true);
    return OutlinedButton.icon(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.clear();
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Login()),
              (route) => false);
        },
        icon: const Icon(Icons.login),
        label: const Text('Log out'));
  }
}
