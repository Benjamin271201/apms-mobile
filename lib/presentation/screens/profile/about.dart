import 'package:apms_mobile/utils/appbar.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBuilder().appBarDefaultBuilder("About"),
        body: Center(
            child: Column(
          children: [const SizedBox(height: 30), Text("EULA & TOS")],
        )));
  }
}
