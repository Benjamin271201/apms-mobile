import 'package:apms_mobile/presentation/components/history/build_card.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatefulWidget {
  final String type;
  const BookingHistory({Key? key, required this.type}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(96, 64, 165, 248),
      body: BuildCard(type: widget.type),
    );
  }
}
