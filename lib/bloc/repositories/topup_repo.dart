import 'package:forex_conversion/forex_conversion.dart';

class TopupRepo {
  Future<int> getExchangeRate() async {
    final fx = Forex();
    Map<String, double> allPrices = await fx.getAllCurrenciesPrices();
    double exchangeRate = allPrices["VND"] ?? 24000.0;
    return exchangeRate.round();
  }
}
