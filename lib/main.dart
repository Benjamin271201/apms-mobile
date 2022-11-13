// @dart=2.9

import 'package:apms_mobile/presentation/screens/history/history.dart';
import 'package:apms_mobile/presentation/screens/home.dart';
import 'package:apms_mobile/presentation/screens/login.dart';
import 'package:apms_mobile/presentation/screens/profile.dart';
import 'package:apms_mobile/presentation/screens/qr_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() => runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen()));

class MyHome extends StatefulWidget {
  final int tabIndex;
  const MyHome({Key key, this.tabIndex}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.jumpToTab(widget.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: screens(),
        items: navBarItems(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 74, 136, 184),
          heroTag: null,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRScan(),
            ));
          },
          child: const Icon(Icons.qr_code_2_sharp),
        ),
      ),
    );
  }

  List<Widget> screens() {
    return [
      const Home(),
      const History(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "Home",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.news),
        title: "History",
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
