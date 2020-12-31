part of 'personal_appointment_bloc.dart';

@immutable
abstract class PersonalAppointmentState {}

class PersonalAppointmentInitial extends PersonalAppointmentState {
  final List<Employee> employees;
  PersonalAppointmentInitial({@required this.employees});
}
