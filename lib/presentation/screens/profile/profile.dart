import 'package:apms_mobile/bloc/profile_bloc.dart';
import 'package:apms_mobile/presentation/screens/authen/sign_in.dart';
import 'package:apms_mobile/themes/colors.dart';
import 'package:apms_mobile/themes/fonts.dart';
import 'package:apms_mobile/themes/icons.dart';
import 'package:flutter/material.dart';
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
    return Card(
        child: ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text("Username goes here", style: titleTextStyle),
      ),
      subtitle: Text("Account balance: 50000"),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
    ));
  }

  Widget _buildProfileOptionsList() {
    return SizedBox(
        width: 400,
        height: 220,
        child: Expanded(
            child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
          _buildOption("Personal Information", profileIcon),
          _buildOption("Transaction History", transactionIcon),
          _buildOption("About", aboutIcon),
        ]).toList())));
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

  Widget _buildPayPalTransactionButton() {
    return SizedBox(
      height: 200,
      width: 200,
      child: TextButton(
          onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                        secretKey:
                            "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
                        transactions: const [
                          {
                            "amount": {
                              "total": '10.12',
                              "currency": "USD",
                              "details": {
                                "subtotal": '10.12',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": [
                                {
                                  "name": "A demo product",
                                  "quantity": 1,
                                  "price": '10.12',
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              "shipping_address": {
                                "recipient_name": "Jane Foster",
                                "line1": "Travis County",
                                "line2": "",
                                "city": "Austin",
                                "country_code": "US",
                                "postal_code": "73301",
                                "phone": "+00000000",
                                "state": "Texas"
                              },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("onSuccess: $params");
                        },
                        onError: (error) {
                          print("onError: $error");
                        },
                        onCancel: (params) {
                          print('cancelled: $params');
                        }),
                  ),
                )
              },
          child: const Text("Make Payment")),
    );
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
