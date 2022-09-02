import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'package:http/http.dart' as http;

const String url_calendario = 'https://pastebin.com/raw/E2mXsZ1X';
const String url_sotg = 'https://forms.gle/CTQYKXWzKHYa4AFi9';
const String url_schedule =
    'https://docs.google.com/spreadsheets/d/1Sny_AVWF0V3ZuiXHJ8sH3AavdueZKcLl/edit?usp=sharing&ouid=104039342941605269966&rtpof=true&sd=true';

class Torneo extends StatefulWidget {
  const Torneo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Torneo> createState() => TorneoState();
}

class TorneoState extends State<Torneo> {
  late Future<Orario> calendario;
  int page = 1;
  List<String> text_appbar = ["Schedule", "Calendario", "SOTG"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(text_appbar[page]),
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
              ListTile(
                title: const Text('SOTG'),
                onTap: () {
                  setState(() {
                    page = 2;
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
                        initialContent: url_schedule,
                        initialSourceType: SourceType.url,
                      ))
                  : page == 1
                      ? DataTable(columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Ora',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Evento',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ], rows: Orario.getCells())
                      : Align(
                          alignment: Alignment.centerRight,
                          child: WebViewX(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            initialContent: url_sotg,
                            initialSourceType: SourceType.url,
                          ))
            ],
          ),
        ));
  }
}

class Orario {
  final String ora;
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

  static List<Orario> getCalendario() {
    List<Orario> calendario = [];

    Future<String> response =
        http.read(Uri.parse('https://pastebin.com/raw/E2mXsZ1X'));

    response.then((value) => print(value));
    String ora = "";
    response.then((value) => value.split(';').map((e) => {
          if (ora == "")
            ora = e
          else
            {calendario.add(Orario(ora: ora, evento: e)), ora = ""}
        }));

    print(calendario);
    return calendario;
  }

  static List<DataRow> getCells() {
    List<DataRow> list = [];

    list.add(
        const DataRow(cells: [DataCell(Text("AAAA")), DataCell(Text("AAAA"))]));
    Orario.getCalendario().forEach((element) => list.add(DataRow(
        cells: [DataCell(Text(element.ora)), DataCell(Text(element.ora))])));

    return list;
  }
}

// Future<Orario> fetchOrario() async {
//   var dio = Dio();
//   final response = await dio.get('https://pastebin.com/raw/E2mXsZ1X');
//   var calendario = Orario.fromJson(response.data);

//   // final response = await http.get(Uri.parse('https://pastebin.com/E2mXsZ1X'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Orario.fromJson(jsonDecode(response.data));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load orario');
//   }
// }
