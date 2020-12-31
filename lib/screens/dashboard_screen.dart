import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = 'dashboard_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: DashboardBody(),
    );
  }
}

class DashboardBody extends StatefulWidget {
  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appointment Confirmation App"),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            BlocListener<DashboardBloc, DashboardState>(
              listener: (context, state) {
                if (state is PersonalAppointmentScreenNavigationState) {
                  navigateToPersonalAppointmentScreen(context, state.employees);
                }
              },
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardInitial) {
                    return _dashboardUI();
                  } else if (state is DashboardLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container();
                },
              ),
            )
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _dashboardUI() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _appointmentDashboardUI(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _textingDashboardUI(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _clientDashboardUI(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _maintenanceDashboardUI(),
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 20.0,
              child: Container(
                child: new Text(
                  "Appointments",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.white,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: 20.0,
              child: Container(
                child: new Text(
                  "Texting",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.white,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.39,
              left: 20.0,
              child: Container(
                child: new Text(
                  "Clients",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.white,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.56,
              left: 20.0,
              child: Container(
                child: new Text(
                  "Maintenance Files",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget _appointmentDashboardUI() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                      width: 2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(PersonalAppointmentScreenNavigationEvent());
                    },
                    child: Text(
                      "Personal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text("Business",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _textingDashboardUI() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                      width: 2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text(
                      "Personal",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text("Business",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _clientDashboardUI() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                      width: 2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      navigateToViewPersonalClientScreen(context);
                    },
                    child: Text(
                      "Personal",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text("Business",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _maintenanceDashboardUI() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                      width: 2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text(
                      "Company",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      navigateToViewEmployeeScreen(context);
                    },
                    child: Text("Employees",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void navigateToPersonalAppointmentScreen(
      BuildContext context, List<Employee> employees) {
    Navigator.pushReplacementNamed(
        context, ViewPersonalAppointmentScreen.routeName,
        arguments: employees);
  }

  void navigateToViewPersonalClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPersonalClientScreen.routeName);
  }

  void navigateToViewEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewEmployeeScreen.routeName);
  }
}
