import 'package:apms_mobile/bloc/topup_bloc.dart';
import 'package:apms_mobile/themes/colors.dart';
import 'package:apms_mobile/utils/appbar.dart';
import 'package:apms_mobile/utils/popup.dart';
import 'package:apms_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:forex_conversion/forex_conversion.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final TopupBloc _topupBloc = TopupBloc();

  int exchangeRate = 24000;
  String selectedPrice = "";
  List<int> priceList = [10000, 20000, 50000, 100000, 200000, 500000];
  List<bool> selectedPriceCard = [false, false, false, false, false, false];

  @override
  void initState() {
    _topupBloc.add(FetchExchangeRate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
        appBar: AppBarBuilder().appBarDefaultBuilder("Topup"),
        body: Column(children: [
          _buildTransactionAmountList(),
          _buildPayPalTransactionButton(),
          _buildPriceSummary()
        ]));
  }

  Widget _buildPriceSummary() {
    return BlocProvider(
        create: (_) => _topupBloc,
        child: BlocBuilder<TopupBloc, TopupState>(builder: (context, state) {
          if (state is ExchangeRateFetching) {
            return Utils().buildLoading();
          } else if (state is ExchangeRateFetchedSuccessfully) {
            exchangeRate = state.exchangeRate;
            return Column(children: [
              Text(
                  "Current exchange rate: 1\$ = ${state.exchangeRate.toString()}"),
              selectedPrice.isEmpty
                  ? const Text("")
                  : Text("Total: $selectedPrice\$")
            ]);
          } else {
            return const Text(
                "Unable to get exchange rate! Please check your internet connection!");
          }
        }));
  }

  Widget _buildTransactionAmountList() {
    return ToggleButtons(
      direction: Axis.vertical,
      onPressed: (int index) {
        setState(() {
          selectedPrice = (priceList[index] / exchangeRate).toStringAsFixed(2);
          for (int i = 0; i < selectedPriceCard.length; i++) {
            selectedPriceCard[i] = i == index;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.red[700],
      selectedColor: Colors.white,
      fillColor: Colors.red[200],
      color: Colors.red[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: selectedPriceCard,
      children: priceList.map((e) => _buildTransactionAmountCard(e)).toList(),
    );
  }

  Widget _buildTransactionAmountCard(int amount) {
    return SizedBox(
      width: 100,
      height: 50,
      child: DecoratedBox(
          decoration: BoxDecoration(border: Border.all()),
          child: Text("${amount.toString()} VND")),
    );
  }

  Widget _buildPayPalTransactionButton() {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
          onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                            "ATieM7Go7V7t-SULEoxgYsiuf7lHDV3XRYKiqYyjfTfvKstL0l211tmjSdUW_h2agCHnUG92Pc-Wusot",
                        secretKey:
                            "EEvIYjJFwy3GyG6cnreRKjrZTzhPmleTVDNZRzE49P-cmh_CpBFP_TPqHGaQT_n_bk1WpaO6YV_Gz6Tj",
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
                        transactions: [
                          {
                            "amount": {
                              "total": selectedPrice,
                              "currency": "USD",
                              "details": {
                                "subtotal": selectedPrice,
                              }
                            },
                            "description": "Topup APMS account",
                            "item_list": {
                              "items": [
                                {
                                  "name": "Topup package: $selectedPrice VND",
                                  "quantity": 1,
                                  "price": selectedPrice,
                                  "currency": "USD"
                                }
                              ],
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("123123123131");
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
}
