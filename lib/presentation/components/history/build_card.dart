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
  void initState() {
    super.initState();
    print('---First----');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.5,
              height: 20,
              child: const Text('From : 2022-01-01'),
            ),
            SizedBox(
                width: width * 0.5,
                height: 20,
                child: const Text(
                  "To: 2022-11-12",
                  textAlign: TextAlign.end,
                )),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return GFCard(
              boxFit: BoxFit.cover,
              //image: Image.asset('your asset image'),
              title: GFListTile(
                avatar: GFAvatar(backgroundImage: loadImage('')),
                title: Text(
                  widget.type,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                subTitle: const Text('FPT car park'),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    child: const Text(
                        "Some quick example text to build on the card\n"
                        "11111"),
                  ),
                  const Divider(
                    color: Colors.blue,
                    //height: 25,
                    thickness: 2,
                  ),
                  SizedBox(
                    width: width,
                    child: const Text('data', textAlign: TextAlign.right),
                  )
                ],
              ),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {
                      print('$index');
                    },
                    text: 'OK',
                    blockButton: true,
                    enableFeedback: false,
                  ),
                  const GFButton(
                    onPressed: null,
                    text: 'Cancel',
                  ),
                ],
              ),
            );
          },
        )),
      ],
    );
  }

  ImageProvider loadImage(String url) {
    var check = RegExp(r'^(https:\/\/firebasestorage\.googleapis\.com\/v0)')
        .hasMatch(url);

    Image img = (url.isEmpty)
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
