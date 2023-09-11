import 'package:flutter/material.dart';
import 'package:nsa_app/services/api_service.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController nomeC = TextEditingController();
  TextEditingController cognomeC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
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
            //container superiore
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
            //Campo nome
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: nomeC,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    hintText: "Nome",
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
                        data: IconThemeData(
                          color: rosso,
                        ),
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Campo cognome
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: cognomeC,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    hintText: "Cognome",
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
                        data: IconThemeData(
                          color: rosso,
                        ),
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Campo username
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: usernameC,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    hintText: "Username",
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
                        data: IconThemeData(
                          color: rosso,
                        ),
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Campo email
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: emailC,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
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
                        data: IconThemeData(
                          color: rosso,
                        ),
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
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
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
                        data: IconThemeData(
                          color: rosso,
                        ),
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
            SizedBox(
              height: 50,
              width: 150,
              child: GestureDetector(
                onTap: () {
                  String nome = nomeC.text;
                  String cognome = cognomeC.text;
                  String username = usernameC.text;
                  String email = emailC.text;
                  String password = passwordC.text;
                  if (email.isNotEmpty &&
                      password.isNotEmpty &&
                      username.isNotEmpty) {
                    APIService.signinC(nome, cognome, username, email, password)
                        .then((value) {
                      if (!value) {
                        APIService.signin(
                                nome, cognome, username, email, password)
                            .then((value) {
                          if (value) {
                            Navigator.of(context)
                                .pushReplacementNamed("/LoginPage");

                            //snackbar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Color.fromARGB(255, 38, 38, 38),
                              duration: Duration(seconds: 1, milliseconds: 5),
                              content: Text(
                                "Registrazione effettuata!",
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                          } else {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Errore nella registrazione!"),
                                    content: const Text("Email non valida."),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Riprova",
                                          style: TextStyle(color: Colors.black),
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
                                title:
                                    const Text("Errore nella registrazione!"),
                                content: const Text("Email già registrata"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Riprova",
                                      style: TextStyle(color: Colors.black),
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
                            title: const Text("Errore nella registrazione!"),
                            content:
                                const Text("I campi non possono essere vuoti"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Riprova",
                                  style: TextStyle(color: Colors.black),
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
                    color: const Color.fromARGB(255, 192, 65, 53),
                  ),
                  child: const Text(
                    "Registrati",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
