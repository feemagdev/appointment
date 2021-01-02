import 'dart:async';

import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/business_appointment_repository.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_business_appointment_event.dart';
part 'add_business_appointment_state.dart';

class AddBusinessAppointmentBloc
    extends Bloc<AddBusinessAppointmentEvent, AddBusinessAppointmentState> {
  AddBusinessAppointmentBloc() : super(AddBusinessAppointmentInitial());

  @override
  Stream<AddBusinessAppointmentState> mapEventToState(
    AddBusinessAppointmentEvent event,
  ) async* {
    if (event is GetEmployeeAndClientDataEvent) {
      yield AddBusinessAppointmentLoadingState();
      List<Employee> employeesList = List();
      List<BusinessClient> bClientsList = List();
      employeesList =
          await EmployeeRepository.defaultConstructor().getEmployeesList();

      bClientsList = await BusinessClientRepository.defaultConstructor()
          .getBusinessClientsList();

      yield GetEmployeeAndClientDataState(
          bClients: bClientsList, employees: employeesList);
    } else if (event is AddBusinessAppointmentButtonEvent) {
      yield AddBusinessAppointmentLoadingState();
      Map<String, dynamic> data = {
        'date_added': event.dateAdded,
        'appointment_date': _changeDate(event.bAppointmentDate),
        'appointment_time': _changeTime(event.bAppointmentTime),
        'bclient_id': event.bClient.getBClientID(),
        'employee_id': event.employee.getEmployeeID(),
        'confirmed': event.confirmed
      };
      bool checkAdded = await BusinessAppointmentRepository.defaultConstructor()
          .createAppointment(data);
      if (checkAdded) {
        yield BusinessAppointmentAddedSuccessfullyState();
      } else {
        yield BusinessAppointmentAddedFailureState();
      }
    }
  }

  DateTime _changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  DateTime _changeTime(TimeOfDay appointmentTime) {
    return DateTime(
        2020, 1, 1, appointmentTime.hour, appointmentTime.minute, 0, 0, 0);
  }
}
