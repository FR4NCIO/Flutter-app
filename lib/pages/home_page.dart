import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: altezza,
                width: larghezza,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/images/atleta.jpg"),
                        opacity: 0.5)),
                child: const Text(
                  "I tuoi atleti",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/AtletiPage");
              },
            ),
          ),
          //footer
          Container(
            color: rosso,
            height: altezza / 17,
            child: const Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Developed by: Gabriele Di Santo",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                //copyright
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Copyright © 2023 Nova Siri Sport Academy Fitness",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
