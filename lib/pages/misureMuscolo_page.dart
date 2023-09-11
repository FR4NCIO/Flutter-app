import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'misure_page.dart';

class MisureMuscoloPage extends StatefulWidget {
  const MisureMuscoloPage({super.key, required this.id});
  final String id;
  @override
  State<MisureMuscoloPage> createState() => _MisureMuscoloPageState();
}

class _MisureMuscoloPageState extends State<MisureMuscoloPage> {
  final Color bianco = const Color.fromARGB(255, 247, 247, 247);
  bool loading = true;
  late List<Map<String, dynamic>> misure = [];

  @override
  void initState() {
    getMisure();
    super.initState();
  }

  void getMisure() async {
    List<Map<String, dynamic>> misure =
        await APIService.pullMisureMuscolo(widget.id);
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
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Le tue misure"),
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
                                    id: widget.id,
                                    muscolo: misure[index]['nome'],
                                  )))));
                        },
                      );
                    },
                  );
                }
              }),
          ],
        ));
  }
}
