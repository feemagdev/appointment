import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/screens/add_employee_screen.dart';
import 'package:appointment/screens/add_personal_appointment_screen.dart';
import 'package:appointment/screens/add_personal_client_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:appointment/screens/update_personal_appointment_screen.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case AddEmployeeScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddEmployeeScreen());
      case AddPersonalAppointmentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => AddPersonalAppointmentScreen());
      case AddPersonalClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddPersonalClientScreen());
      case ViewPersonalAppointmentScreen.routeName:
        List<Employee> employees = args;
        return MaterialPageRoute(
            builder: (_) =>
                ViewPersonalAppointmentScreen(employees: employees));
      case ViewPersonalClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewPersonalClientScreen());
      case ViewEmployeeScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewEmployeeScreen());
      case UpdatePersonalAppointmentScreen.routeName:
        List list = args;
        Employee oldEmployee = list[0];
        PersonalAppointment oldAppointment = list[1];
        PersonalClient oldClient = list[2];
        return MaterialPageRoute(
            builder: (_) => UpdatePersonalAppointmentScreen(
                  oldAppointment: oldAppointment,
                  oldClient: oldClient,
                  oldEmployee: oldEmployee,
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
