class BusinessAppointment {
  int _bAppointmentID;
  DateTime _dateAdded;
  int _employeeID;
  int _bClientID;
  DateTime _appointmentDate;
  DateTime _appointmentTime;
  bool _confirmed;

  BusinessAppointment.fromMap(Map snapshot)
      : _bAppointmentID = snapshot['id'],
        _dateAdded = DateTime.tryParse(snapshot['date_added']),
        _employeeID = snapshot['employee_id'],
        _bClientID = snapshot['bclient_id'],
        _appointmentDate = DateTime.tryParse(snapshot['appointment_date']),
        _appointmentTime = DateTime.tryParse(snapshot['appointment_time']),
        _confirmed = snapshot['confirmed'];

  int getBAppointmentID() {
    return _bAppointmentID;
  }

  DateTime getDateAdded() {
    return _dateAdded;
  }

  int getEmployeeID() {
    return _employeeID;
  }

  int getBClientID() {
    return _bClientID;
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

  void setBClientID(int bClientID) {
    _bClientID = bClientID;
  }

  void setEmployeeID(int employeeID) {
    _employeeID = employeeID;
  }

  void setDateAdded(DateTime date) {
    _dateAdded = date;
  }
}
