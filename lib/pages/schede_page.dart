import 'package:flutter/material.dart';
import 'package:nsa_app/services/api_service.dart';
import 'package:nsa_app/pages/esercizi_page.dart';

class SchedePage extends StatefulWidget {
  const SchedePage({super.key, required this.id});
  final String id;

  @override
  State<SchedePage> createState() => _SchedePageState();
}

class _SchedePageState extends State<SchedePage> {
  bool loading = true;
  late List<Map<String, dynamic>> schede = [];
  Color bianco = const Color.fromARGB(255, 247, 247, 247);

  @override
  void initState() {
    getSchede();
    super.initState();
  }

  void getSchede() async {
    List<Map<String, dynamic>> schede = await APIService.pullSchede(widget.id);
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
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Le tue schede"),
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
                    return ListTile(
                      title: Text(
                        "${schede[index]['nome']}",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => (EserciziPage(
                                id: schede[index]['id'],
                                nome: schede[index]['nome'])))));
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
