import 'package:flutter/material.dart';
import 'package:nsa_app/services/shared_preferences_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String nome = "";
  late String cognome = "";
  late String username = "";
  late String email = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    String? nome = await SPService.getString("nome");
    if (nome == null) return;
    setState(() => this.nome = nome);

    String? cognome = await SPService.getString("cognome");
    if (cognome == null) return;
    setState(() => this.cognome = cognome);

    String? username = await SPService.getString("username");
    if (username == null) return;
    setState(() => this.username = username);

    String? email = await SPService.getString("email");
    if (email == null) return;
    setState(() => this.email = email);
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/atleta.jpg"),
                fit: BoxFit.cover,
                opacity: 0.5)),
        height: altezza,
        width: larghezza,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nome:  $nome",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Cognome:  $cognome",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Username:  $username",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Email:  $email",
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  SPService.removeString("id");
                  SPService.removeString("nome");
                  SPService.removeString("cognome");
                  SPService.removeString("username");
                  SPService.removeString("email");
                  SPService.removeString("password");

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 38, 38, 38),
                    duration: Duration(seconds: 1, milliseconds: 5),
                    content: Text(
                      "Log Out effettuato!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ));

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/LoginPage", (route) => false);
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
