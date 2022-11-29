import 'package:apms_mobile/bloc/profile_bloc.dart';
import 'package:apms_mobile/presentation/screens/authen/sign_in.dart';
import 'package:apms_mobile/presentation/screens/profile/topup.dart';
import 'package:apms_mobile/themes/colors.dart';
import 'package:apms_mobile/themes/fonts.dart';
import 'package:apms_mobile/themes/icons.dart';
import 'package:apms_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void initState() {
    _profileBloc.add(FetchProfileInformation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _buildProfileAppBar()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildBriefAccountInformationCard(),
            _buildProfileOptionsList(),
            _logOutButton()
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAppBar() {
    return AppBar(
      title: const Text('Profile', style: TextStyle(color: deepBlue)),
      backgroundColor: lightBlue,
    );
  }

  Widget _buildBriefAccountInformationCard() {
    return BlocProvider(
        create: (_) => _profileBloc,
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileFetchedSuccessfully) {
            return Card(
                child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(state.profile.fullName, style: titleTextStyle),
              ),
              subtitle: Row(children: [
                Text("Account balance: ${state.profile.accountBalance} VND"),
                const Spacer(),
                IconButton(
                    icon: addIcon,
                    onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const TopUp()))
                        .then((value) =>
                            {_profileBloc.add(FetchProfileInformation())}))
              ]),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            ));
          } else {
            return const Card();
          }
        }));
  }

  Widget _buildProfileOptionsList() {
    return SizedBox(
        width: 400,
        height: 220,
        child: ListView(
            children: ListTile.divideTiles(context: context, tiles: [
          _buildOption("Personal Information", profileIcon),
          _buildOption("Topup History", transactionIcon),
          _buildOption("About", aboutIcon),
        ]).toList()));
  }

  Widget _buildOption(String optionName, Icon optionIcon) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(padding: const EdgeInsets.only(right: 10), child: optionIcon),
          Text(optionName),
          const Spacer(),
          navigateIcon
        ]));
  }

  Widget _logOutButton() {
    final navigator = Navigator.of(context, rootNavigator: true);
    return OutlinedButton.icon(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.clear();
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false);
        },
        icon: const Icon(Icons.login),
        label: const Text('Log out'));
  }
}
