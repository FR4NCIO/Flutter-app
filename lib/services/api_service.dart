import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nsa_app/services/shared_preferences_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> signin(String nome, String cognome, String username,
      String email, String password) async {
    final url = Uri.https("nsafitness.it", "/applicazione/signin.php");

    final response = await client.post(url, body: {
      "nome": nome,
      "cognome": cognome,
      "username": username,
      "email": email,
      "passw": password,
    });

    print("Status code signin ${response.statusCode}");
    print("resBody signin ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['Signin']) {
        print("Registrazione effettuata");
        return true;
      } else {
        print("Registrazione non effettuata");
        return false;
      }
    } else {
      print("Registrazione non effettuata, cod: ${response.statusCode}");
      return false;
    }
  }

  static Future<bool> signinC(String nome, String cognome, String username,
      String email, String password) async {
    final url = Uri.https("nsafitness.it", "/applicazione/signinC.php");

    final response = await client.post(url, body: {
      "email": email,
    });

    print("Status code signinC ${response.statusCode}");
    print("resBody signinC ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['Check']) {
        print("Email già presente");
        return true;
      } else {
        print("Email non presente");
        return false;
      }
    } else {
      print("Controllo non effettuato, cod: ${response.statusCode}");
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    final url = Uri.https("nsafitness.it", "/applicazione/login.php");
    final response = await client.post(url, body: {
      "email": email,
      "passw": password,
    });

    print("Status code ${response.statusCode}");
    print("resBody ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['Login']) {
        //print("accesso effettuato");
        SPService.addString("id", resBody['id']);
        SPService.addString("nome", resBody['nome']);
        SPService.addString("cognome", resBody['cognome']);
        SPService.addString("username", resBody['username']);
        SPService.addString("email", resBody['email']);
        return true;
      } else {
        //print("accesso non effettuato");
        return false;
      }
    } else {
      //print("accesso non effettuato, cod: ${response.statusCode}");
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> pullSchede(String idUtente) async {
    final url = Uri.https("nsafitness.it", "/applicazione/pull/pullSchede.php");
    final response = await client.post(url, body: {"id": idUtente});

    print("Status code pullSchede ${response.statusCode}");
    print("resBody pullSchede ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> schede = [];

      resBody.forEach((element) {
        final Map<String, dynamic> scheda = {
          "id": element["id"],
          "nome": element["nome"],
          "idUtente": element["idUtente"]
        };
        schede.add(scheda);
      });

      return schede;
    } else {
      throw Exception('pullSchede fallito');
    }
  }

  static Future<List<Map<String, dynamic>>> pullMisure(
      String idUtente, String muscolo) async {
    final url = Uri.https("nsafitness.it", "/applicazione/pull/pullMisure.php");
    final response =
        await client.post(url, body: {"id": idUtente, "nome": muscolo});

    print("Status code pullMisure ${response.statusCode}");
    print("resBody pullMisure ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> misure = [];

      resBody.forEach((element) {
        final Map<String, dynamic> misura = {
          "id": element["id"],
          "nome": element["nome"],
          "data": element["data"],
          "valore": element["valore"],
          "idUtente": element["idUtente"]
        };
        misure.add(misura);
      });

      return misure;
    } else {
      throw Exception('pullMisure fallito');
    }
  }

  static Future<List<Map<String, dynamic>>> pullMisureMuscolo(
      String idUtente) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/pull/pullMisureMuscolo.php");
    final response = await client.post(url, body: {"id": idUtente});

    print("Status code pullMisureMuscolo ${response.statusCode}");
    print("resBody pullMisureMuscolo ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> misure = [];

      resBody.forEach((element) {
        final Map<String, dynamic> misura = {
          "id": element["id"],
          "nome": element["nome"],
          "data": element["data"],
          "valore": element["valore"],
          "idUtente": element["idUtente"]
        };
        misure.add(misura);
      });

      return misure;
    } else {
      throw Exception('pullMisureMuscolo fallito');
    }
  }

  static Future<bool> updateEsercizio(
    String id,
    String carichi,
    String appunti,
  ) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/update/updateEsercizio.php");
    final response = await client.post(url, body: {
      "id": id,
      "carichi": carichi,
      "appunti": appunti,
    });

    print("Status code updateEsercizio ${response.statusCode}");
    print("resBody updateEsercizio ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['updateEsercizio']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> pullEsercizi(
      String idScheda) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/pull/pullEsercizi.php");
    final response = await client.post(url, body: {"id": idScheda});

    print("Status code pullEsercizi ${response.statusCode}");
    print("resBody pullEsercizi ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> esercizi = [];

      resBody.forEach((element) {
        final Map<String, dynamic> esercizio = {
          "id": element["id"],
          "nome": element["nome"],
          "ripetizioni": element["ripetizioni"],
          "serie": element["serie"],
          "pausa": element["pausa"],
          "carichi": element["carichi"],
          "appunti": element["appunti"],
          "pausaPost": element["pausaPost"],
          "idScheda": element["idScheda"]
        };
        esercizi.add(esercizio);
      });

      return esercizi;
    } else {
      throw Exception('pullEsercizi fallito');
    }
  }
}
