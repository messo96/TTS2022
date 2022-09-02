import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'package:http/http.dart' as http;

const String regolamento =
    "Partita di 60 minuti, half time a 30 minuti oppure a 7 punti.Dopo l'half time si riprende subito a giocare senza pausa.\nPunteggio massimo 13 o una volta finito il tempo c'è il CAP 1.\nUn timeout per squadra, non negli ultimi 5 minuti, \ndurata del timeout 1 minuto.\nSi ricorda che il format del torneo prevede almeno una donna in campo ogni meta.";

const String url_calendario = 'https://pastebin.com/raw/E2mXsZ1X';
const String url_sotg = 'https://forms.gle/CTQYKXWzKHYa4AFi9';
const String url_schedule =
    '<iframe src="https://docs.google.com/spreadsheets/d/1Sny_AVWF0V3ZuiXHJ8sH3AavdueZKcLl/edit?usp=sharing&ouid=104039342941605269966&rtpof=true&sd=true" width="640" height="2734" frameborder="0" marginheight="0" marginwidth="0">Caricamento…</iframe>';

class Torneo extends StatefulWidget {
  const Torneo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Torneo> createState() => TorneoState();
}

class TorneoState extends State<Torneo> {
  late Future<Orario> calendario;
  int page = 0;
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
        actions: <Widget>[
          TextButton(
              onPressed: () {
                setState(() {
                  page = 1;
                });
              },
              child: const Text(
                'Calendario',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  page = 0;
                });
              },
              child: const Text(
                'Schedule',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  page = 2;
                });
              },
              child: const Text(
                'SOTG',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
          child: Row(
        children: [
          page == 0
              ? (Column(children: [
                  const Text("REGOLAMENTO"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        regolamento,
                        overflow: TextOverflow.visible,
                      )),
                  const SizedBox(height: 10),
                  WebViewX(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    initialContent: url_schedule,
                    initialSourceType: SourceType.html,
                  )
                ]))
              : page == 1
                  ? DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Orario',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Evento',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: Orario.getCells(),
                    )
                  : (WebViewX(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      initialContent:
                          '<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSczBeFbNUQwPxI19mkF1AwkEB4ezCqcmiWEA-uNXbVOj5R3vA/viewform?embedded=true" width="${MediaQuery.of(context).size.width}" height="${MediaQuery.of(context).size.height}" frameborder="0" marginheight="0" marginwidth="0">Caricamento…</iframe>',
                      initialSourceType: SourceType.html,
                    ))
        ],
      )),
    );
  }
}

class Orario {
  final String ora;
  final String evento;

  const Orario({
    required this.ora,
    required this.evento,
  });

  static Future<List<Orario>> getCalendario() async {
    List<Orario> calendario = [];
    String ora = "";
    LineSplitter ls = LineSplitter();

    await http
        .read(Uri.parse('https://pastebin.com/raw/E2mXsZ1X'))
        .then((value) => ls.convert(value).forEach((element) {
              List<String> line = element.split(';');
              calendario.add(Orario(ora: line[0], evento: line[1]));
            }));
    return calendario;
  }

  static List<DataRow> getCells() {
    List<DataRow> list = [];
    list.add(DataRow(cells: [DataCell(Text("Sabato")), DataCell(Text(""))]));
    list.add(DataRow(
        cells: [DataCell(Text("9:30")), DataCell(Text("Inizio partite"))]));
    list.add(DataRow(cells: [
      DataCell(Text("dalle 13:30 alle 15")),
      DataCell(Text("Pausa pranzo"))
    ]));
    list.add(DataRow(
        cells: [DataCell(Text("18:30")), DataCell(Text("Fine partite"))]));
    list.add(DataRow(cells: [
      DataCell(Text("18:45")),
      DataCell(Text("Torneo di spikeball"))
    ]));
    list.add(DataRow(cells: [
      DataCell(Text("La sera")),
      DataCell(Text("festa della birra,\ncon tanta festa e tanta birra"))
    ]));
    list.add(DataRow(cells: [DataCell(Text("Domenica")), DataCell(Text(""))]));
    list.add(DataRow(cells: [
      DataCell(Text("dalle 8:00 alle 9:30")),
      DataCell(Text("Colazione"))
    ]));
    list.add(DataRow(
        cells: [DataCell(Text("9:30")), DataCell(Text("Inizio partite"))]));
    list.add(DataRow(cells: [
      DataCell(Text("dalle 13:30 alle 15")),
      DataCell(Text("Pausa pranzo"))
    ]));
    list.add(DataRow(
        cells: [DataCell(Text("17:30 circa")), DataCell(Text("Premiazioni"))]));

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
