import 'package:flutter/material.dart';
import 'package:nsa_app_giuseppe/pages/esercizi_page.dart';
import '/services/api_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SchedePage extends StatefulWidget {
  const SchedePage({super.key, required this.utente});
  final Map<String, dynamic> utente;

  @override
  State<SchedePage> createState() => _SchedePageState();
}

class _SchedePageState extends State<SchedePage> {
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  bool loading = true;
  TextEditingController nomeC = TextEditingController();
  late List<Map<String, dynamic>> schede = [];

  @override
  void initState() {
    getSchede();
    super.initState();
  }

  void getSchede() async {
    List<Map<String, dynamic>> schede =
        await APIService.pullSchede(widget.utente['id']);
    setState(() {
      this.schede = schede;
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
              child: Text(
                  "Schede di ${widget.utente['nome']} ${widget.utente['cognome']}"),
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
              if (schede.isEmpty) {
                return const Center(
                  child: Text(
                    "Nessuna scheda presente",
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: bianco,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: schede.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          //azione per eliminare la scheda
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: const Text("Eliminazione Scheda"),
                                  content: const Text(
                                      "Si desidera davvero eliminare la scheda selezionata?"),
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
                                          APIService.removeScheda(
                                                  schede[index]['id'])
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
                                                  "Scheda eliminata!",
                                                  style:
                                                      TextStyle(color: bianco),
                                                ),
                                              ));
                                              setState(() {
                                                loading = true;
                                                getSchede();
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
                                                  "Scheda non eliminata!",
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
                        title: Text(
                          "${schede[index]['nome']}",
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => (EserciziPage(
                                    id: schede[index]["id"],
                                    nome: schede[index]['nome'],
                                  )))));
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
            //creazione nuova scheda
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(
                    "Inserimento nuova scheda per ${widget.utente['nome']}",
                  ),
                  content: Column(
                    children: [
                      TextFormField(
                        controller: nomeC,
                        decoration:
                            const InputDecoration(hintText: "Nome scheda"),
                      ),
                    ],
                  ),
                  //annulla, aggiungi
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          nomeC.clear();
                        },
                        child: const Text(
                          "Annulla",
                        )),
                    ElevatedButton(
                        onPressed: () {
                          String nome =
                              nomeC.text == "" ? "Scheda" : nomeC.text;
                          // "aggiungi messaggio di errore"
                          APIService.pushScheda(nome, widget.utente['id']);
                          setState(() {
                            loading = true;
                            getSchede();
                          });
                          Navigator.pop(context);
                          nomeC.clear();
                        },
                        child: const Text(
                          "Aggiungi",
                        )),
                  ],
                );
              },
            );
          }),
    );
  }
}
