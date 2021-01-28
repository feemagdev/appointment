import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class PersonalClientRepository {
  PersonalClientRepository.defaultConstructor();
  Future<PersonalClient> addClient(Map data) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.post('${url}client/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 201) {
      return PersonalClient.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

/*
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('client').add(data);
        */
  }

  Future<PersonalClient> getClientData(int id) async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}client/$id/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      return PersonalClient.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

    /*
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('client').doc(clientID).get();
    return PersonalClient.fromMap(snapshot.data());

    */
  }

  Future<List<PersonalClient>> getClientsList() async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}client/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<PersonalClient> clients = List<PersonalClient>.from(
          l.map((model) => PersonalClient.fromMap(model)));
      return clients;
    } else {
      return null;
    }

    /*
    var auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = "http://faheem.pythonanywhere.com/api/client/";
    var response =
        await http.get(url, headers: <String, String>{'authorization': auth});
    print(json.decode(response.body));
    */
    /*
    Iterable l = json.decode(response.body);
    List<PersonalClient> clients = List<PersonalClient>.from(
        l.map((model) => PersonalClient.fromMap(model)));
*/

/*
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('client').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<PersonalClient> clients = List();
      snapshot.docs.forEach((element) {
        clients.add(PersonalClient.fromMap(element.data(), element.id));
      });
      return clients;
    } */
  }

  Future<bool> updateClient(Map data, int id) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.put('${url}client/$id/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;

    /*final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('client').doc(clientID).update(data);
    return true;
    */
  }
}
