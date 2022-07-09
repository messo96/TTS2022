import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SpritzRace.dart';

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
  final String club_ippodromo = "clubippodromo";
  final String comune_di_cesena = "comune_di_cesena";
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
                  throw 'Could not launch $club_ippodromo';
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
                            if (!await launchUrl(Uri.parse(IG + club_ippodromo),
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $club_ippodromo';
                            }
                          },
                          child: const SizedBox(
                            width: 100,
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/ippo_club_cesena.png'),
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
                    Card(
                      elevation: 3.0,
                      child: InkWell(
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse(IG + comune_di_cesena),
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $comune_di_cesena';
                            }
                          },
                          child: const SizedBox(
                            width: 100,
                            height: 80,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/comune_cesena.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(45),
                    child: Column(
                      children: const [
                        Image(image: AssetImage('assets/images/logo.png')),
                        Text(
                          "2nd Edition",
                          style: TextStyle(
                              fontFamily: 'Quicksand', height: 2, fontSize: 50),
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
                              builder: (context) => const SpritzRace(
                                    title: "SPRITZ RACE",
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.local_drink,
                        color: Colors.green,
                        size: 24.0,
                        semanticLabel: 'Come partecipare allo spritz race',
                      ),
                      label: const Text("SPRITZ RACE"),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        MapsLauncher.launchQuery('Atletica Endas Cesena');
                      },
                      icon: const Icon(
                        Icons.map,
                        color: Colors.indigo,
                        size: 24.0,
                        semanticLabel: 'Indicazioni per arrivare al torneo',
                      ),
                      label: const Text("COME ARRIVARE"),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.yellow,
                      size: 24.0,
                      semanticLabel: 'Entra nel vivo del torneo',
                    ),
                    label: const Text("ENTRA NEL TORNEO"),
                  ),
                )
              ])),
        ));
  }
}
