part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class PersonalAppointmentScreenNavigationState extends DashboardState {
  final List<Employee> employees;
  PersonalAppointmentScreenNavigationState({@required this.employees});
}

class DashboardLoadingState extends DashboardState {}
