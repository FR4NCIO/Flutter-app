import 'package:flutter/material.dart';
import 'misureMuscolo_page.dart';
import 'schede_page.dart';

class BaseAtletaPage extends StatelessWidget {
  const BaseAtletaPage({super.key, required this.utente});
  final Map<String, dynamic> utente;

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 38, 38),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logoB.png",
              width: 45,
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("${utente["nome"]} ${utente["cognome"]}"),
            ),
          ],
        ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Schede di ${utente['nome']} ${utente['cognome']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => (SchedePage(
                          utente: utente,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Misure di ${utente['nome']} ${utente['cognome']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => (MisureMuscoloPage(
                          utente: utente,
                        )))));
              },
            ),
          ),
        ],
      ),
    );
  }
}
