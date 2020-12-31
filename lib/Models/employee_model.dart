class Employee {
  final String _employeeID;
  final String _employeeName;

  Employee(this._employeeID, this._employeeName);

  Employee.fromMap(Map snapshot, String employeeID)
      : _employeeID = employeeID,
        _employeeName = snapshot['employee_name'];

  String getEmployeeID() {
    return _employeeID;
  }

  String getEmployeeName() {
    return _employeeName;
  }
}
