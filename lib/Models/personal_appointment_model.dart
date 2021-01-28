class PersonalAppointment {
  int _appointmentID;
  DateTime _dateAdded;
  int _employeeID;
  int _clientID;
  DateTime _appointmentDate;
  DateTime _appointmentTime;
  bool _confirmed;

  PersonalAppointment.fromMap(Map snapshot)
      : _appointmentID = snapshot['id'],
        _dateAdded = DateTime.tryParse(snapshot['date_added']),
        _employeeID = snapshot['employee_id'],
        _clientID = snapshot['client_id'],
        _appointmentDate = DateTime.tryParse(snapshot['appointment_date']),
        _appointmentTime = DateTime.tryParse(snapshot['appointment_time']),
        _confirmed = snapshot['confirmed'];

  int getAppointmentID() {
    return _appointmentID;
  }

  DateTime getDateAdded() {
    return _dateAdded;
  }

  int getEmployeeID() {
    return _employeeID;
  }

  int getClientID() {
    return _clientID;
  }

  DateTime getAppointmentDate() {
    return _appointmentDate;
  }

  DateTime getAppointmentTime() {
    return _appointmentTime;
  }

  bool getStatus() {
    return _confirmed;
  }

  void setAppointmentDate(DateTime date) {
    _appointmentDate = date;
  }

  void setAppointmentTime(DateTime time) {
    _appointmentTime = time;
  }

  void setStatus(bool status) {
    _confirmed = status;
  }

  void setClientID(int clientID) {
    _clientID = clientID;
  }

  void setEmployeeID(int employeeID) {
    _employeeID = employeeID;
  }

  void setDateAdded(DateTime date) {
    _dateAdded = date;
  }
}
