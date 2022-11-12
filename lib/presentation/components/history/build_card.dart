import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class BuildCard extends StatefulWidget {
  final String type;
  const BuildCard({Key? key, required this.type}) : super(key: key);

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
            avatar: GFAvatar(backgroundImage: loadImage('')),
            title: Text(
              widget.type,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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

  ImageProvider loadImage(String? url) {
    Image img = (url!.isEmpty)
        ? Image.asset("assets/images/default.jpg")
        : Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null)
                    ? child
                    : const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/default.jpg");
            },
          );
    return img.image;
  }
}
