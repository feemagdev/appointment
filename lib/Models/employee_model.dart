class Employee {
  int _employeeID;
  String _employeeName;
  String _employeePhone;

  Employee.fromMap(Map snapshot)
      : _employeeID = snapshot['id'],
        _employeeName = snapshot['name'],
        _employeePhone = snapshot['phone'];

  int getEmployeeID() {
    return _employeeID;
  }

  String getEmployeeName() {
    return _employeeName;
  }

  String getEmployeePhone() {
    return _employeePhone;
  }

  void setEmployeeName(String name) {
    _employeeName = name;
  }

  void setEmployeePhone(String phone) {
    _employeePhone = phone;
  }
}
