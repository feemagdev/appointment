import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class BusinessClientRepository {
  BusinessClientRepository.defaultConstructor();
  Future<BusinessClient> addBusinessClient(Map data) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.post('${url}bclient/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    print(response.body);
    if (response.statusCode == 201) {
      return BusinessClient.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

    /*final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('business_client').add(data);
    return await getBusinessClientData(reference.id);

    */
  }

  Future<BusinessClient> getBusinessClientData(int bClientID) async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}bclient/$bClientID/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      return BusinessClient.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

    /*final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('business_client').doc(bClientID).get();
    print("dara");
    print(snapshot.data());
    return BusinessClient.fromMap(snapshot.data());
    */
  }

  Future<List<BusinessClient>> getBusinessClientsList() async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}bclient/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<BusinessClient> bclients = List<BusinessClient>.from(
          l.map((model) => BusinessClient.fromMap(model)));
      return bclients;
    } else {
      return null;
    }

    /*
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await dbReference.collection('business_client').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<BusinessClient> bClients = List();
      snapshot.docs.forEach((element) {
        bClients.add(BusinessClient.fromMap(element.data(), element.id));
      });
      return bClients;
    }
    */
  }

  Future<bool> updateBusinessClient(Map data, int bClientID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.put('${url}bclient/$bClientID/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
    /*
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('business_client').doc(bClientID).update(data);
    return true;

    */
  }
}
