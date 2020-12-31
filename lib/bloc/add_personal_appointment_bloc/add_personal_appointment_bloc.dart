import 'dart:async';

import 'package:appointment/Models/client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/client_repository.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:appointment/Repositories/personal_appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_personal_appointment_event.dart';
part 'add_personal_appointment_state.dart';

class AddPersonalAppointmentBloc
    extends Bloc<AddPersonalAppointmentEvent, AddPersonalAppointmentState> {
  AddPersonalAppointmentBloc() : super(AddPersonalAppointmentInitial());

  @override
  Stream<AddPersonalAppointmentState> mapEventToState(
    AddPersonalAppointmentEvent event,
  ) async* {
    if (event is GetEmployeeAndClientDataEvent) {
      yield AddPersonalAppointmentLoadingState();
      List<Employee> employeesList = List();
      List<Client> clientsList = List();
      employeesList =
          await EmployeeRepository.defaultConstructor().getEmployeesList();

      clientsList =
          await ClientRepository.defaultConstructor().getClientsList();

      yield GetEmployeeAndClientDataState(
          clients: clientsList, employees: employeesList);
    } else if (event is AddPersonalAppointmentButtonEvent) {
      yield AddPersonalAppointmentLoadingState();
      Map<String, dynamic> data = {
        'date_added': event.dateAdded,
        'appointment_date': changeDate(event.appointmentDate),
        'appointment_time': changeTime(event.appointmentTime),
        'client_id': event.client.getClientID(),
        'employee_id': event.employee.getEmployeeID(),
        'confirmed': event.confirmed
      };
      bool checkAdded = await PersonalAppointmentRepository.defaultConstructor()
          .createAppointment(data);
      if (checkAdded) {
        yield PersonalAppointmentAddedSuccessfullyState();
      } else {
        yield PersonalAppointmentAddedFailureState();
      }
    }
  }

  DateTime changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  DateTime changeTime(TimeOfDay appointmentTime) {
    return DateTime(
        2020, 1, 1, appointmentTime.hour, appointmentTime.minute, 0, 0, 0);
  }
}
