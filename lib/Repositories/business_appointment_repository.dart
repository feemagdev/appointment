import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class BusinessAppointmentRepository {
  BusinessAppointmentRepository.defaultConstructor();

  Future<bool> createAppointment(Map data) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.post('${url}bappointment/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
    /*final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('business_appointment').add(data);
    if (reference.id.isEmpty) {
      return false;
    } else {
      return true;
    }
    */
  }

  Future<List<BusinessAppointment>> getEmployeeBusinessAppointments(
      DateTime date, int employeeID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.get(
        '${url}bappointment/?employee_id=$employeeID&appointment_date=$date',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        });

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<BusinessAppointment> bappointments = List<BusinessAppointment>.from(
          l.map((model) => BusinessAppointment.fromMap(model)));
      return bappointments;
    } else {
      return null;
    }
    /*final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('business_appointment')
        .where('appointment_date', isEqualTo: date)
        .where('employee_id', isEqualTo: employeeID)
        .orderBy('appointment_time')
        .get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<BusinessAppointment> appointments = List();
      snapshot.docs.forEach((element) {
        appointments
            .add(BusinessAppointment.fromMap(element.data(), element.id));
      });
      return appointments;
    }  */
  }

  Future<bool> updateAppointment(Map data, int bAppointmentID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.put('${url}bappointment/$bAppointmentID/',
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
    await dbReference
        .collection('business_appointment')
        .doc(bAppointmentID)
        .update(data);
    return true; */
  }

  Future<bool> deleteAppointment(int bAppointmentID) async {
    String token = Api.token;
    String url = Api.url;

    var response =
        await http.delete('${url}bappointment/$bAppointmentID/', headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Token $token'
    });
    print(response.statusCode);
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
    /*final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('business_appointment')
        .doc(bAppointmentID)
        .delete();
    return true;*/
  }
}
