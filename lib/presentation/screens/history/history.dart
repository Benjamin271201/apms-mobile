import 'package:apms_mobile/presentation/screens/history/booking_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final int selectedTab;
  const History({Key? key, this.selectedTab = 0}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedTab,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.4),
                labelColor: Colors.white,
                labelPadding: const EdgeInsets.symmetric(horizontal: 30),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 30, 216, 129),
                      width: 2), // Indicator height
                  //insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
                ),
                tabs: tabs(),
              )),
        ),
        body: TabBarView(children: tabBarItems()),
      ),
    );
  }

  List<Widget> tabBarItems() {
    return const [
      BookingHistory(type: "Booking"), // Index : 0
      BookingHistory(type: "Parking"), // Index : 1
      BookingHistory(type: "Done"), // Index : 2
      BookingHistory(type: "Cancel"), // Index : 3
    ];
  }

  List<Widget> tabs() {
    return [
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.ticket),
            Text('BOOKING'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.clock),
            Text('PARKING'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.check_mark),
            Text('DONE'),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.xmark_seal),
            Text('CANCEL'),
          ],
        ),
      ),
    ];
  }
}
