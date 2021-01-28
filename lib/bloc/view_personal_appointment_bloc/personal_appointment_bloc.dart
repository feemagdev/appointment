import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/repositories/personal_appointment_repository.dart';
import 'package:appointment/repositories/personal_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personal_appointment_event.dart';
part 'personal_appointment_state.dart';

class PersonalAppointmentBloc
    extends Bloc<PersonalAppointmentEvent, PersonalAppointmentState> {
  final List<Employee> employees;
  PersonalAppointmentBloc({@required this.employees})
      : super(PersonalAppointmentInitial(employees: employees));

  @override
  Stream<PersonalAppointmentState> mapEventToState(
    PersonalAppointmentEvent event,
  ) async* {
    if (event is GetPersonalAppointmentDataEvent) {
      yield PersonalAppointmentLoadingState();

      List<PersonalAppointment> appointments = await getPersonalAppointment(
          _changeDate(event.date).toIso8601String(), event.employeeID);

      if (appointments != null) {
        List<PersonalClient> clients = List();
        clients = await getPersonalClient(appointments);
        yield GetPersonalAppointmentDataState(
            appointments: appointments, clients: clients);
      } else {
        yield NoPersonalAppointmentBookedState();
      }
    } else if (event is DeletePersonalAppointmentEvent) {
      yield PersonalAppointmentLoadingState();
      bool check = await PersonalAppointmentRepository.defaultConstructor()
          .deleteAppointment(event.appointmentID);
      if (check) {
        yield PersonalAppointmentDeletedSuccessfully();
      }
    }
  }

  Future<List<PersonalAppointment>> getPersonalAppointment(
      String date, int employeeID) async {
    return await PersonalAppointmentRepository.defaultConstructor()
        .getEmployeePersonalAppointments(date, employeeID);
  }

  Future<List<PersonalClient>> getPersonalClient(
      List<PersonalAppointment> appointments) async {
    List<PersonalClient> clients = List();
    await Future.forEach(appointments, (PersonalAppointment appointment) async {
      clients.add(await PersonalClientRepository.defaultConstructor()
          .getClientData(appointment.getClientID()));
    });
    return clients;
  }

  DateTime _changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }
}
