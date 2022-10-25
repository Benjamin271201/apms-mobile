import 'package:apms_mobile/home.dart';
import 'package:apms_mobile/profile.dart';
import 'package:apms_mobile/qr_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
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
      Home(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(icon: const Icon(CupertinoIcons.home),
      title: "Home",
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: CupertinoColors.systemGrey
      ),
      PersistentBottomNavBarItem(icon: const Icon(CupertinoIcons.person),
      title: "Profile",
      activeColorPrimary: Colors.blueAccent,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }
}
