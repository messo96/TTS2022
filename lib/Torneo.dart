import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class Torneo extends StatefulWidget {
  const Torneo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Torneo> createState() => TorneoState();
}

class TorneoState extends State<Torneo> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Time To Shine 2'),
          actions: [],
          automaticallyImplyLeading: true,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Schedule'),
                onTap: () {
                  setState(() {
                    page = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Calendario'),
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              page == 0
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: WebViewX(
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.height,
                        initialContent:
                            'https://docs.google.com/spreadsheets/d/1rRDBFN01TflG7F7GZXm3ufIRQ6RhJd6evhNjKiYmBbs/edit?usp=sharing',
                        initialSourceType: SourceType.url,
                      ))
                  : Table(
                      defaultColumnWidth: FixedColumnWidth(60.0),
                      children: [
                          TableRow(children: [
                            Column(children: [
                              Text('Website', style: TextStyle(fontSize: 20.0))
                            ]),
                            Column(children: [
                              Text('Tutorial', style: TextStyle(fontSize: 20.0))
                            ]),
                            Column(children: [
                              Text('Review', style: TextStyle(fontSize: 20.0))
                            ]),
                          ]),
                        ]),
            ],
          ),
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
