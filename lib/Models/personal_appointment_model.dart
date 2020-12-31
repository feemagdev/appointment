class PersonalAppointment {
  String _appointmentID;
  DateTime _dateAdded;
  String _employeeID;
  String _clientID;
  DateTime _appointmentDate;
  DateTime _appointmentTime;

  PersonalAppointment.fromMap(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _dateAdded = snapshot['date_added'],
        _employeeID = snapshot['employee_id'],
        _clientID = snapshot['client_id'],
        _appointmentDate = snapshot['appointment_date'],
        _appointmentTime = snapshot['appointment_time'];

  String getAppointmentID() {
    return _appointmentID;
  }

  DateTime getDateAdded() {
    return _dateAdded;
  }

  String getEmployeeID() {
    return _employeeID;
  }

  String getClientID() {
    return _clientID;
  }

  DateTime getAppointmentDate() {
    return _appointmentDate;
  }

  DateTime getAppointmentTime() {
    return _appointmentTime;
  }
}
