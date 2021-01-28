import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/company_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  CompanyRepository.defaultConstructor();

  Future<bool> saveCompanyDetails(Map data, int id) async {
    String token = Api.token;
    String url = Api.url;
    if (id == null) {
      var response = await http.post('${url}company/',
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: 'Token $token'
          },
          body: jsonEncode(data));
      print(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } else {
      var response = await http.put('${url}company/$id/',
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: 'Token $token'
          },
          body: jsonEncode(data));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    }

    /*final dbReference = FirebaseFirestore.instance;
    if (id == null) {
      await dbReference.collection('company').add(map);
      return true;
    } else {
      await dbReference.collection('company').doc(id).update(map);
      return true;
    } */
  }

  Future<Company> getCompanyDetails() async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}company/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Company> company =
          List<Company>.from(l.map((model) => Company.fromMap(model)));
      if (company.isEmpty) {
        return null;
      } else {
        return company.first;
      }
    } else {
      return null;
    }
    /*
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('company').get();
    if (snapshot.size != 0) {
      return Company.fromMap(
          snapshot.docs.first.data(), snapshot.docs.first.id);
    } else
      return null;
      */
  }
}
