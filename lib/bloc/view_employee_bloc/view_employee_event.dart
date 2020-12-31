part of 'view_employee_bloc.dart';

@immutable
abstract class ViewEmployeeEvent {}

class GetEmployeesListEvent extends ViewEmployeeEvent {}

class ViewSelectedEmployeeEvent extends ViewEmployeeEvent {
  final Employee employee;
  ViewSelectedEmployeeEvent({@required this.employee});
}
