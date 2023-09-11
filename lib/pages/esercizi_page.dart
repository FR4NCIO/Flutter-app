import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../services/api_service.dart';

class EserciziPage extends StatefulWidget {
  const EserciziPage({super.key, required this.id, required this.nome});
  final String id;
  final String nome;

  @override
  State<EserciziPage> createState() => _EserciziPageState();
}

class _EserciziPageState extends State<EserciziPage> {
  bool loading = true;
  TextEditingController carichiC = TextEditingController();
  TextEditingController appuntiC = TextEditingController();
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  late List<Map<String, dynamic>> esercizi = [];

  @override
  void initState() {
    getEsercizi();
    super.initState();
  }

  void getEsercizi() async {
    List<Map<String, dynamic>> esercizi =
        await APIService.pullEsercizi(widget.id);
    setState(() {
      this.esercizi = esercizi;
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
              child: Text(widget.nome),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (loading == true)
            const Center(child: CircularProgressIndicator())
          else
            Builder(builder: (context) {
              if (esercizi.isEmpty) {
                return const Center(
                  child: Text("Nessun esercizio presente"),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: bianco,
                    height: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: esercizi.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          //azione per modificare l'esercizio
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: const Text("Modifica appunti"),
                                  content: Column(children: [
                                    TextFormField(
                                        controller: carichiC,
                                        decoration: const InputDecoration(
                                            hintText: "Carichi")),
                                    TextFormField(
                                        controller: appuntiC,
                                        decoration: const InputDecoration(
                                            hintText: "Appunti")),
                                  ]),
                                  icon: const Icon(Icons.edit),
                                  iconColor: Colors.grey,
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          carichiC.clear();
                                          appuntiC.clear();
                                        },
                                        child: const Text("Annulla")),
                                    ElevatedButton(
                                        onPressed: () {
                                          APIService.updateEsercizio(
                                                  esercizi[index]['id'],
                                                  carichiC.text,
                                                  appuntiC.text)
                                              .then((value) {
                                            if (value) {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    const Color(0xFF202020),
                                                duration: const Duration(
                                                    seconds: 1,
                                                    milliseconds: 5),
                                                content: Text(
                                                  "Esercizio modificato!",
                                                  style:
                                                      TextStyle(color: bianco),
                                                ),
                                              ));
                                              setState(() {
                                                loading = true;
                                                getEsercizi();
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    const Color(0xFF202020),
                                                duration: const Duration(
                                                    seconds: 1,
                                                    milliseconds: 5),
                                                content: Text(
                                                  "Esercizio non modificato!",
                                                  style:
                                                      TextStyle(color: bianco),
                                                ),
                                              ));
                                            }
                                          });
                                        },
                                        child: const Text("Conferma")),
                                  ],
                                ),
                              );
                            },
                            icon: Icons.edit,
                            foregroundColor: Colors.grey,
                            backgroundColor: const Color(0xFF202020),
                            label: "Modifica",
                          ),
                        ],
                      ),
                      //
                      child: ListTile(
                        title: Text("${esercizi[index]['nome']}"),
                        subtitle: Text(esercizi[index]['pausaPost'] == ""
                            ? "${esercizi[index]['serie']} x ${esercizi[index]['ripetizioni']} \npausa: ${esercizi[index]['pausa']}"
                            : "${esercizi[index]['serie']} x ${esercizi[index]['ripetizioni']} \npausa: ${esercizi[index]['pausa']} \npausa fine esercizio: ${esercizi[index]['pausaPost']}"),
                        trailing: const Icon(
                          Icons.navigate_next,
                          size: 25,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  scrollable: true,
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Carichi",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(esercizi[index]['carichi'] == ""
                                          ? "Nessun carico"
                                          : esercizi[index]['carichi']),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        "Appunti",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(esercizi[index]['appunti'] == ""
                                          ? "Nessun appunto"
                                          : esercizi[index]['appunti']),
                                    ],
                                  ),
                                );
                              });
                        },
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
