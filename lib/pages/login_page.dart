import 'package:flutter/material.dart';
import 'package:nsa_app/services/api_service.dart';
import 'package:nsa_app/services/shared_preferences_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool hidePassword = true;
  Color rosso = const Color.fromARGB(255, 192, 65, 53);
  Color bianco = const Color.fromARGB(255, 247, 247, 247);
  Color nero = const Color.fromARGB(255, 38, 38, 38);

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //container superiore con logo
              Container(
                width: larghezza,
                height: altezza / 3.5,
                decoration: BoxDecoration(
                  color: bianco,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                  ),
                ),
                //logo
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
              //Campo email
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: emailC,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 15),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: rosso,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: rosso,
                          width: 1,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: IconTheme(
                          data: IconThemeData(color: rosso),
                          child: const Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Campo Password
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: passwordC,
                    style: const TextStyle(fontSize: 18),
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 15),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: rosso,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: rosso,
                          width: 1,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: IconTheme(
                          data: IconThemeData(color: rosso),
                          child: const Icon(Icons.lock),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
              ),
              //creare "password dimenticata"

              //Pulsante Login
              SizedBox(
                height: 50,
                width: 150,
                child: GestureDetector(
                  onTap: () {
                    String email = emailC.text;
                    String password = passwordC.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      APIService.login(email, password).then((value) {
                        if (value) {
                          SPService.addString("password", password);
                          Navigator.of(context)
                              .pushReplacementNamed("/HomePage");
                        } else {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text("Errore nell'accesso!"),
                                  content: const Text(
                                      "Account inesistente o credenziali errate"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Riprova",
                                      ),
                                    )
                                  ],
                                );
                              }));
                        }
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text("Errore nell'acceso!"),
                              content: const Text(
                                  "I campi non possono essere vuoti"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Riprova",
                                  ),
                                )
                              ],
                            );
                          }));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: rosso,
                    ),
                    child: const Text(
                      "Accedi",
                      style: TextStyle(fontSize: 16, letterSpacing: 1),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text("Non sei registrato?"),
              ),
              //Pulsante Signin
              SizedBox(
                height: 50,
                width: 150,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/SigninPage");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: rosso,
                    ),
                    child: const Text(
                      "Registrati",
                      style: TextStyle(fontSize: 16, letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
