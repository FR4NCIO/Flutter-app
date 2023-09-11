import 'package:flutter/material.dart';
import 'package:nsa_app/services/api_service.dart';
import 'package:nsa_app/services/shared_preferences_service.dart';

class SavedLoginPage extends StatefulWidget {
  const SavedLoginPage({super.key});

  @override
  State<SavedLoginPage> createState() => _SavedLoginPageState();
}

class _SavedLoginPageState extends State<SavedLoginPage> {
  late String email = "";
  late String password = "";

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      logIn();
    });
  }

  Future getData() async {
    String? email = await SPService.getString("email");
    if (email == null) return;
    setState(() => this.email = email);

    String? password = await SPService.getString("password");
    if (password == null) return;
    setState(() => this.password = password);
  }

  void logIn() {
    APIService.login(email, password).then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed("/HomePage");
      } else {
        Navigator.of(context).pushReplacementNamed("/LoginPage");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
            width: 160,
            height: 160,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 80, right: 80),
            child: LinearProgressIndicator(),
          ),
        ]);
  }
}
