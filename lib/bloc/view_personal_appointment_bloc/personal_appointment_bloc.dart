import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
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
  ) async* {}
}
