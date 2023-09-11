import 'package:flutter/material.dart';
import 'package:nsa_app/pages/misureMuscolo_page.dart';
import 'package:nsa_app/pages/schede_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nsa_app/services/shared_preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    String? id = await SPService.getString("id");
    if (id == null) return;
    setState(() => this.id = id);
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    Color rosso = const Color.fromARGB(255, 192, 65, 53);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logoB.png",
              width: 45,
              height: 45,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("NSA Fitness App"),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/ProfilePage");
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Column(
        children: [
          //container schede
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: altezza,
                width: larghezza,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage(
                      "assets/images/schede.jpeg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Le tue schede",
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => (SchedePage(
                          id: id,
                        )))));
              },
            ),
          ),
          //container misure
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: altezza,
                width: larghezza,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage(
                        "assets/images/misure.jpeg",
                      ),
                      fit: BoxFit.cover),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Le tue misure",
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => (MisureMuscoloPage(
                          id: id,
                        )))));
              },
            ),
          ),
          //footer
          Container(
            color: rosso,
            height: altezza / 18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //social
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Seguici sui nostri social",
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: const BoxConstraints(),
                      splashRadius: 5,
                      icon: const Icon(FontAwesomeIcons.instagram),
                      iconSize: 19,
                      onPressed: () {
                        _launchUrl(
                            "https://www.instagram.com/nsa_fitness_center/");
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: const BoxConstraints(),
                      splashRadius: 5,
                      icon: const Icon(FontAwesomeIcons.facebook),
                      iconSize: 19,
                      onPressed: () {
                        _launchUrl("https://www.facebook.com/NovaSiriAcademy/");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: altezza / 1000,
                  width: larghezza,
                ),
                //developed by
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Developed by: Gabriele Di Santo",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 5),
                      constraints: const BoxConstraints(),
                      splashRadius: 5,
                      icon: const Icon(FontAwesomeIcons.instagram),
                      iconSize: 19,
                      onPressed: () {
                        _launchUrl("https://www.instagram.com/_stfu.gabriele_");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _launchUrl(String url_) async {
  final Uri url = Uri.parse(url_);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url_');
  }
}
