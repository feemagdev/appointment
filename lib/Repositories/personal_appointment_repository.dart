import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class PersonalAppointmentRepository {
  PersonalAppointmentRepository.defaultConstructor();

  Future<bool> createAppointment(Map data) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.post('${url}pappointment/',
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
    /*
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('personal_appointment').add(data);
    if (reference.id.isEmpty) {
      return false;
    } else {
      return true;
    }
    */
  }

  Future<List<PersonalAppointment>> getEmployeePersonalAppointments(
      String date, int employeeID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.get(
        '${url}pappointment/?employee_id=$employeeID&appointment_date=$date',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        });

    print(response.body);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<PersonalAppointment> appointments = List<PersonalAppointment>.from(
          l.map((model) => PersonalAppointment.fromMap(model)));
      return appointments;
    } else {
      return null;
    }

/*

    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('personal_appointment')
        .where('appointment_date', isEqualTo: date)
        .where('employee_id', isEqualTo: employeeID)
        .orderBy('appointment_time')
        .get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<PersonalAppointment> appointments = List();
      snapshot.docs.forEach((element) {
        appointments
            .add(PersonalAppointment.fromMap(element.data(), element.id));
      });
      return appointments;
    }

    */
  }

  Future<bool> updateAppointment(Map data, int appointmentID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.put('${url}pappointment/$appointmentID/',
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
    await dbReference
        .collection('personal_appointment')
        .doc(appointmentID)
        .update(data);
    return true; */
  }

  Future<bool> deleteAppointment(int appointmentID) async {
    String token = Api.token;
    String url = Api.url;

    var response =
        await http.delete('${url}pappointment/$appointmentID/', headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Token $token'
    });
    print(response.statusCode);
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
    /*
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('personal_appointment')
        .doc(appointmentID)
        .delete();
    return true; */
  }
}
