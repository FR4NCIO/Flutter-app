import 'package:flutter/material.dart';
import 'package:nsa_app_giuseppe/services/api_service.dart';
import 'package:nsa_app_giuseppe/pages/atleta_page.dart';

class AtletiPage extends StatefulWidget {
  const AtletiPage({super.key});

  @override
  State<AtletiPage> createState() => _AtletiPageState();
}

class _AtletiPageState extends State<AtletiPage> {
  TextEditingController ricerca = TextEditingController();
  bool loading = true;
  late List<Map<String, dynamic>> utenti = [];
  late List<Map<String, dynamic>> utentiCopia = [];

  @override
  void initState() {
    getUtenti();
    super.initState();
  }

  void getUtenti() async {
    List<Map<String, dynamic>> utenti = await APIService.pullUtenti();
    setState(() {
      utentiCopia = utenti;
      this.utenti = utentiCopia;
      loading = false;
    });
  }

  void getRicerca(String query) {
    setState(() {
      utenti = utentiCopia
          .where((element) =>
              element["nome"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("I tuoi atleti"),
      ),
      body: Column(
        children: [
          //barra di ricerca
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                getRicerca(value);
              },
              controller: ricerca,
              decoration: const InputDecoration(
                  labelText: "Ricerca",
                  hintText: "Ricerca per nome",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          //lista utenti
          if (loading == true)
            const Center(child: CircularProgressIndicator())
          else
            Builder(builder: (context) {
              if (utenti.isEmpty) {
                return const Center(
                  child: Text(
                    "Nessun utente presente nel database",
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: utenti.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${utenti[index]['nome']} ${utenti[index]['cognome']}",
                      ),
                      subtitle: Text(
                        "Username: ${utenti[index]['username']}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => (BaseAtletaPage(
                                  utente: utenti[index],
                                )))));
                      },
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
