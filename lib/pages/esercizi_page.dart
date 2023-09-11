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
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  late List<Map<String, dynamic>> esercizi = [];
  TextEditingController nomeC = TextEditingController();
  TextEditingController ripetizioniC = TextEditingController();
  TextEditingController serieC = TextEditingController();
  TextEditingController pausaC = TextEditingController();
  TextEditingController carichiC = TextEditingController();
  TextEditingController appuntiC = TextEditingController();
  TextEditingController pausaPostC = TextEditingController();

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
                          //azione per eliminare l'esercizio
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: const Text("Eliminazione esercizio"),
                                  content: const Text(
                                      "Si desidera davvero eliminare l'esercizio selezionato?"),
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
                                          APIService.removeEsercizio(
                                                  esercizi[index]['id'])
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
                                                  "Esercizio eliminata!",
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
                                                  "Esercizio non eliminato!",
                                                  style:
                                                      TextStyle(color: bianco),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 192, 65, 53),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Inserimento nuovo esercizio"),
                    content: Column(children: [
                      TextFormField(
                        controller: nomeC,
                        decoration: const InputDecoration(hintText: "Nome"),
                      ),
                      TextFormField(
                        controller: ripetizioniC,
                        decoration:
                            const InputDecoration(hintText: "ripetizioni"),
                      ),
                      TextFormField(
                        controller: serieC,
                        decoration: const InputDecoration(hintText: "serie"),
                      ),
                      TextFormField(
                        controller: pausaC,
                        decoration: const InputDecoration(hintText: "pausa"),
                      ),
                      TextFormField(
                        controller: carichiC,
                        decoration: const InputDecoration(hintText: "carichi"),
                      ),
                      TextFormField(
                        controller: appuntiC,
                        decoration: const InputDecoration(hintText: "appunti"),
                      ),
                      TextFormField(
                        controller: pausaPostC,
                        decoration: const InputDecoration(
                            hintText: "pausa fine esercizio"),
                      ),
                    ]),
                    //pulsanti
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            nomeC.clear();
                            ripetizioniC.clear();
                            serieC.clear();
                            pausaC.clear();
                            carichiC.clear();
                            appuntiC.clear();
                            pausaPostC.clear();
                          },
                          child: const Text(
                            "Annulla",
                          )),
                      ElevatedButton(
                          onPressed: () {
                            APIService.pushEsercizio(
                                    nomeC.text,
                                    ripetizioniC.text,
                                    serieC.text,
                                    pausaC.text,
                                    carichiC.text,
                                    appuntiC.text,
                                    pausaPostC.text,
                                    widget.id)
                                .then((value) {
                              if (value) {
                                setState(() {
                                  loading = true;
                                  getEsercizi();
                                });
                                Navigator.pop(context);
                                nomeC.clear();
                                ripetizioniC.clear();
                                serieC.clear();
                                pausaC.clear();
                                carichiC.clear();
                                appuntiC.clear();
                                pausaPostC.clear();
                              }
                            });
                          },
                          child: const Text(
                            "Aggiungi",
                          )),
                    ],
                  );
                });
          }),
    );
  }
}
