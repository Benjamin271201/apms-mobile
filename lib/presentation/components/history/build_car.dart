import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class BuildCard extends StatefulWidget {
  const BuildCard({Key? key}) : super(key: key);

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return GFCard(
          boxFit: BoxFit.cover,
          //image: Image.asset('your asset image'),
          title: GFListTile(
            avatar: GFAvatar(
                backgroundImage: loadImage(
                    'https://firebasestorage.googleapis.com/v0/b/apms-48bd5/o/capture_51H-14532.png?alt=media&token=97cc1d20-3da1-4c68-a71')),
            title: const Text(
              '51H - 68329',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            subTitle: const Text('FPT car park'),
          ),
          content: const Text("Some quick example text to build on the card"),
          buttonBar: GFButtonBar(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            runAlignment: WrapAlignment.end,
            children: <Widget>[
              GFButton(
                onPressed: () {},
                text: 'OK',
              ),
              GFButton(
                onPressed: () {},
                text: 'Cancel',
              ),
            ],
          ),
        );
      },
    );
  }

  ImageProvider loadImage(String url) {
    return FadeInImage(
      image: NetworkImage(url),
      placeholder: const AssetImage('assets/images/default.jpg'),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/default.jpg');
      },
    ).image;
  }
}
