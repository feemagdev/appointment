part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeEvent {}

class AddEmployeeButtonEvent extends AddEmployeeEvent {
  final String name;
  AddEmployeeButtonEvent({@required this.name});
}
