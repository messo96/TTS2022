import 'package:TimeToShine/Piantina.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Torneo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time To Shine 2022',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Time To Shine 2nd Edition'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String IG = "https://www.instagram.com/";
  final String la_forlivese_ig = "torrefazione_la_forlivese";
  final String pol_buscherini = "pol_buscherini";
  final String _45giri = "45girifrisbee";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Made with 💚 by "),
            InkWell(
              onTap: () async {
                if (!await launchUrl(Uri.parse(IG + _45giri),
                    mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $pol_buscherini';
                }
              },
              child: const Image(
                  width: 45,
                  height: 45,
                  image: AssetImage("assets/images/45giri.png")),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Column(children: [
                const Text("Supported by: "),
                const Divider(
                  height: 15,
                  thickness: 1,
                  indent: 60,
                  endIndent: 60,
                  color: Color.fromARGB(255, 194, 133, 64),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 3.0,
                      child: InkWell(
                          onTap: () async {
                            if (!await launchUrl(Uri.parse(IG + pol_buscherini),
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $pol_buscherini';
                            }
                          },
                          child: const SizedBox(
                            width: 100,
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/buscherini_logo.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                    ),
                    Card(
                      elevation: 3.0,
                      child: InkWell(
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse(IG + la_forlivese_ig),
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $la_forlivese_ig';
                            }
                          },
                          child: const SizedBox(
                            width: 130,
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/la_forlivese.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    const Card(
                      margin: EdgeInsets.only(right: 10),
                      elevation: 3.0,
                      child: InkWell(
                          onTap: null,
                          child: SizedBox(
                            width: 100,
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image(
                                image:
                                    AssetImage('assets/images/beer_fest.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(45),
                    child: Column(
                      children: const [
                        Image(image: AssetImage('assets/images/logo.png')),
                        Text(
                          "2nd Edition",
                          style: TextStyle(
                              fontFamily: 'Quicksand', height: 2, fontSize: 40),
                        ),
                        Text(
                          "L'erba è sempre più verde",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Piantina(),
                            ));
                      },
                      icon: const Icon(
                        Icons.map_sharp,
                        color: Colors.green,
                        size: 24.0,
                        semanticLabel:
                            'Mostra la piantina del luogo in cui si svolge il torneo',
                      ),
                      label: const Text("Piantina Torneo"),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        MapsLauncher.launchQuery(
                            'Polisportiva Buscherini Forlì');
                      },
                      icon: const Icon(
                        Icons.location_on_sharp,
                        color: Colors.indigo,
                        size: 24.0,
                        semanticLabel: 'Indicazioni per arrivare al torneo',
                      ),
                      label: const Text("COME ARRIVARE"),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Torneo(
                                  title: "Time To Shine 2",
                                )),
                      );
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.yellow,
                      size: 24.0,
                      semanticLabel: 'Entra nel vivo del torneo',
                    ),
                    label: const Text("VEDI SCHEDULE E CALENDARIO"),
                  ),
                )
              ])),
        ));
  }
}
