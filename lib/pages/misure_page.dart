import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/api_service.dart';

class MisurePage extends StatefulWidget {
  const MisurePage({super.key, required this.id, required this.muscolo});
  final String id;
  final String muscolo;

  @override
  State<MisurePage> createState() => _MisurePageState();
}

class _MisurePageState extends State<MisurePage> {
  bool loading = true;
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  late List<Map<String, dynamic>> misure = [];

  @override
  void initState() {
    getMisure();
    super.initState();
  }

  void getMisure() async {
    List<Map<String, dynamic>> misure =
        await APIService.pullMisure(widget.id, widget.muscolo);
    setState(() {
      this.misure = misure;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Misure ${widget.muscolo}"),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //elenco dei muscoli
          if (loading == true)
            const Center(child: CircularProgressIndicator())
          else
            Builder(builder: (context) {
              if (misure.isEmpty) {
                return const Center(
                  child: Text("Nessuna misura presente"),
                );
              } else {
                //"aggiungi modifica ed elimina"
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: bianco,
                    height: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: misure.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        //elimina
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                scrollable: true,
                                title: const Text("Eliminazione misura"),
                                content: const Text(
                                    "Si desidera davvero eliminare la misura selezionata?"),
                                icon: const Icon(Icons.delete),
                                iconColor: Colors.red,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No")),
                                  ElevatedButton(
                                      onPressed: () {
                                        APIService.removeMisura(
                                                misure[index]['id'])
                                            .then((value) {
                                          if (value) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  const Color(0xFF202020),
                                              duration: const Duration(
                                                  seconds: 1, milliseconds: 5),
                                              content: Text(
                                                "Misura eliminata!",
                                                style: TextStyle(color: bianco),
                                              ),
                                            ));
                                            setState(() {
                                              loading = true;
                                              getMisure();
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  const Color(0xFF202020),
                                              duration: const Duration(
                                                  seconds: 1, milliseconds: 5),
                                              content: Text(
                                                "Misura non eliminata!",
                                                style: TextStyle(color: bianco),
                                              ),
                                            ));
                                          }
                                        });
                                      },
                                      child: const Text("Sì")),
                                ],
                              ),
                            );
                          },
                          icon: Icons.delete,
                          foregroundColor: Colors.red,
                          backgroundColor: const Color(0xFF202020),
                          label: "Elimina",
                        ),

                        //modifica
                      ]),
                      child: ListTile(
                        title: Text("${misure[index]['valore']} cm"),
                        subtitle: Text(
                          "${misure[index]['data']}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
        ],
      ),
    );
  }
}
