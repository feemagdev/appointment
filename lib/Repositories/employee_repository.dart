import 'dart:convert';
import 'dart:io';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/api/api.dart';
import 'package:http/http.dart' as http;

class EmployeeRepository {
  EmployeeRepository.defaultConstructor();

  Future<Employee> addEmployee(Map data) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.post('${url}employee/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 201) {
      return Employee.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

    /* final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('employee').add(map);

    return await getEmployeeData(reference.id); */
  }

  Future<Employee> getEmployeeData(int employeeID) async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}employee/$employeeID/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      return Employee.fromMap(jsonDecode(response.body) as Map);
    } else {
      return null;
    }

    /*  final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('employee').doc(employeeID).get();
    return Employee.fromMap(snapshot.data(), snapshot.id);

    */
  }

  Future<List<Employee>> getEmployeesList() async {
    String token = Api.token;
    String url = Api.url;
    var response = await http.get(
      '${url}employee/',
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token"
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Employee> employees =
          List<Employee>.from(l.map((model) => Employee.fromMap(model)));
      return employees;
    } else {
      return null;
    }
    /*  final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('employee').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<Employee> employees = List();
      snapshot.docs.forEach((element) {
        employees.add(Employee.fromMap(element.data(), element.id));
      });
      return employees;
    }

    */
  }

  Future<bool> updateEmployee(Map data, int employeeID) async {
    String token = Api.token;
    String url = Api.url;

    var response = await http.put('${url}employee/$employeeID/',
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
    /* final dbRefernece = FirebaseFirestore.instance;
    await dbRefernece.collection('employee').doc(employeeID).update(data);
    return true;

    */
  }
}
