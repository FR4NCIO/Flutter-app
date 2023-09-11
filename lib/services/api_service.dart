import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<List<Map<String, dynamic>>> pullUtenti() async {
    final url = Uri.https("nsafitness.it", "/applicazione/pull/pullUtenti.php");
    final response = await client.post(url);

    print("Status code pullUtenti ${response.statusCode}");
    print("resBody pullUtenti ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> utenti = [];

      resBody.forEach((element) {
        final Map<String, dynamic> utente = {
          "id": element["id"],
          "nome": element["nome"],
          "cognome": element["cognome"],
          "username": element["username"],
        };
        utenti.add(utente);
      });

      return utenti;
    } else {
      throw Exception('pullUtenti fallito');
    }
  }

  //schede
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

  static Future<bool> pushScheda(String nome, String idUtente) async {
    final url = Uri.https("nsafitness.it", "/applicazione/push/pushScheda.php");
    final response =
        await client.post(url, body: {"nome": nome, "idUtente": idUtente});

    print("Status code pushScheda ${response.statusCode}");
    print("resBody pushScheda ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> removeScheda(String id) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/remove/removeScheda.php");
    final response = await client.post(url, body: {"id": id});

    print("Status code removeScheda ${response.statusCode}");
    print("resBody removeScheda ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['removeScheda']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //esercizi
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

  static Future<bool> pushEsercizio(
      String nome,
      String ripetizioni,
      String serie,
      String pausa,
      String? carichi,
      String? appunti,
      String? pausaPost,
      String idScheda) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/push/pushEsercizio.php");
    final response = await client.post(url, body: {
      "nome": nome,
      "ripetizioni": ripetizioni,
      "serie": serie,
      "pausa": pausa,
      "carichi": carichi,
      "appunti": appunti,
      "pausaPost": pausaPost,
      "idScheda": idScheda
    });

    print("Status code pushEsercizio ${response.statusCode}");
    print("resBody pushEsercizio ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['pushEsercizio']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> removeEsercizio(String id) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/remove/removeEsercizio.php");
    final response = await client.post(url, body: {"id": id});

    print("Status code removeEsercizio ${response.statusCode}");
    print("resBody removeEsercizio ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['removeEsercizio']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //misure
  static Future<bool> pushMisura(
      String nome, String data, String valore, String idUtente) async {
    final url = Uri.https("nsafitness.it", "/applicazione/push/pushMisura.php");
    final response = await client.post(url, body: {
      "nome": nome,
      "data": data,
      "valore": valore,
      "idUtente": idUtente
    });

    print("Status code pushMisura ${response.statusCode}");
    print("resBody pushMisura ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['pushMisura']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> removeMisura(String id) async {
    final url =
        Uri.https("nsafitness.it", "/applicazione/remove/removeMisura.php");
    final response = await client.post(url, body: {"id": id});

    print("Status code removeMisura ${response.statusCode}");
    print("resBody removeMisura ${response.body}");

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      if (resBody['removeMisura']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
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
}
