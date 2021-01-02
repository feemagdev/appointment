class Employee {
  String _employeeID;
  String _employeeName;

  Employee.fromMap(Map snapshot, String employeeID)
      : _employeeID = employeeID,
        _employeeName = snapshot['employee_name'];

  String getEmployeeID() {
    return _employeeID;
  }

  String getEmployeeName() {
    return _employeeName;
  }

  void setEmployeeName(String name) {
    _employeeName = name;
  }
}
