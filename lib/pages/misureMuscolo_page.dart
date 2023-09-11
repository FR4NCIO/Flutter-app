import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'misure_page.dart';

class MisureMuscoloPage extends StatefulWidget {
  const MisureMuscoloPage({super.key, required this.utente});
  final Map<String, dynamic> utente;

  @override
  State<MisureMuscoloPage> createState() => _MisureMuscoloPageState();
}

class _MisureMuscoloPageState extends State<MisureMuscoloPage> {
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  bool loading = true;
  TextEditingController nomeC = TextEditingController();
  TextEditingController valoreC = TextEditingController();
  TextEditingController dataC = TextEditingController();
  late String data;
  late List<Map<String, dynamic>> misure = [];

  @override
  void initState() {
    getMisure();
    super.initState();
  }

  void getMisure() async {
    List<Map<String, dynamic>> misure =
        await APIService.pullMisureMuscolo(widget.utente['id']);
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
              child: Text(
                  "Misure di ${widget.utente['nome']} ${widget.utente['cognome']}"),
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
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: bianco,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: misure.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${misure[index]['nome']}"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => (MisurePage(
                                  id: widget.utente["id"],
                                  muscolo: misure[index]['nome'],
                                )))));
                      },
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
            //creazione nuova misura
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(
                    "Inserimento nuova misura per ${widget.utente['nome']}",
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nomeC,
                        decoration:
                            const InputDecoration(hintText: "Nome misura"),
                      ),
                      TextFormField(
                        controller: valoreC,
                        decoration:
                            const InputDecoration(hintText: "Valore in cm"),
                      ),
                      TextField(
                        controller: dataC,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Data"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            data = DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              dataC.text = data;
                            });
                          }
                        },
                      )
                    ],
                  ),

                  //annulla, aggiungi
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          nomeC.clear();
                          valoreC.clear();
                        },
                        child: const Text(
                          "Annulla",
                        )),
                    ElevatedButton(
                        onPressed: () {
                          String nome = nomeC.text;
                          String valore = valoreC.text;

                          APIService.pushMisura(
                                  nome, data, valore, widget.utente['id'])
                              .then((value) {
                            if (value) {
                              setState(() {
                                loading = true;
                                getMisure();
                              });
                            } else {
                              //messaggio di errore
                            }
                          });

                          Navigator.pop(context);
                          nomeC.clear();
                          valoreC.clear();
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
