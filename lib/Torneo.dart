import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'package:http/http.dart' as http;

class Torneo extends StatefulWidget {
  const Torneo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Torneo> createState() => TorneoState();
}

class TorneoState extends State<Torneo> {
  late Future<Orario> calendario;
  int page = 0;
  final String src =
      'https://docs.google.com/spreadsheets/d/1Sny_AVWF0V3ZuiXHJ8sH3AavdueZKcLl/edit?usp=sharing&ouid=104039342941605269966&rtpof=true&sd=true';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    calendario = fetchOrario();

    print("CIAAAAAAO");
    calendario.then((value) => print(value));
  }

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
                title: const Text('Calendario'),
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Schedule'),
                onTap: () {
                  setState(() {
                    page = 0;
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
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        initialContent: src,
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

class Orario {
  final int ora;
  final String evento;

  const Orario({
    required this.ora,
    required this.evento,
  });

  factory Orario.fromJson(Map<String, dynamic> json) {
    return Orario(
      ora: json['ora'],
      evento: json['evento'],
    );
  }
}

Future<Orario> fetchOrario() async {
  var dio = Dio();
  final response = await dio.get('https://pastebin.com/E2mXsZ1X');
  print(response.data);

  // final response = await http.get(Uri.parse('https://pastebin.com/E2mXsZ1X'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Orario.fromJson(jsonDecode(response.data));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load orario');
  }
}
