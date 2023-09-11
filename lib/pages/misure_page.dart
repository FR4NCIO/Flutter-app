import 'package:flutter/material.dart';
import 'package:nsa_app/services/api_service.dart';

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
        title: const Text("Le tue misure"),
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
                    return ListTile(
                      title: Text("${misure[index]['valore']} cm"),
                      subtitle: Text(
                        "${misure[index]['data']}",
                        style: const TextStyle(color: Colors.grey),
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
