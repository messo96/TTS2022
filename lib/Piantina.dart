import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Piantina extends StatefulWidget {
  const Piantina({Key? key}) : super(key: key);

  @override
  State<Piantina> createState() => PiantinaState();
}

class PiantinaState extends State<Piantina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          automaticallyImplyLeading: true,
        ),
        body: PhotoView(
          imageProvider: const AssetImage("assets/images/piantina.jpeg"),
        ));
  }
}

/*Row(children: [
          Table(defaultColumnWidth: FixedColumnWidth(60.0), children: [
            TableRow(children: [
              Column(children: [
                Text('Website', style: TextStyle(fontSize: 20.0))
              ]),
              Column(children: [
                Text('Tutorial', style: TextStyle(fontSize: 20.0))
              ]),
              Column(
                  children: [Text('Review', style: TextStyle(fontSize: 20.0))]),
            ]),
          ]),
          Container(
            width: 100,
            height: 100,
            child: const WebViewX(
              width: 100,
              height: 100,
              initialContent:
                  'https://docs.google.com/spreadsheets/d/1rRDBFN01TflG7F7GZXm3ufIRQ6RhJd6evhNjKiYmBbs/edit?usp=sharing',
              initialSourceType: SourceType.url,
            ),
          )
        ])*/
