// @dart=2.9

import 'package:apms_mobile/presentation/screens/history/history.dart';
import 'package:apms_mobile/presentation/screens/home.dart';
import 'package:apms_mobile/presentation/screens/login.dart';
import 'package:apms_mobile/presentation/screens/profile.dart';
import 'package:apms_mobile/presentation/screens/qr_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: LoginScreen()));
}

class MyHome extends StatefulWidget {
  final int tabIndex;
  final int headerTabIndex;
  const MyHome({Key key, this.tabIndex, this.headerTabIndex = 0})
      : super(key: key);

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
    return MaterialApp(
        theme: ThemeData(fontFamily: "Inter"),
        home: Scaffold(
          body: PersistentTabView(
            context,
            controller: _controller,
            screens: screens(),
            items: navBarItems(),
          ),
        ));
  }

  List<Widget> screens() {
    return [
      const Home(),
      History(
        selectedTab: widget.headerTabIndex,
      ),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: "History",
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
