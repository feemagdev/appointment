part of 'business_appointment_bloc.dart';

@immutable
abstract class BusinessAppointmentEvent {}

class GetBusinessAppointmentDataEvent extends BusinessAppointmentEvent {
  final int employeeID;
  final DateTime date;
  GetBusinessAppointmentDataEvent(
      {@required this.date, @required this.employeeID});
}

class DeleteBusinessAppointmentEvent extends BusinessAppointmentEvent {
  final int appointmentID;
  DeleteBusinessAppointmentEvent({@required this.appointmentID});
}
