import 'package:apms_mobile/presentation/components/history/build_card.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(96, 64, 165, 248),
      body: BuildCard(),
    );
  }
}
