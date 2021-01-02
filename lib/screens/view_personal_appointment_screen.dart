import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/bloc/view_personal_appointment_bloc/personal_appointment_bloc.dart';
import 'package:appointment/screens/add_personal_appointment_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:appointment/screens/update_personal_appointment_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewPersonalAppointmentScreen extends StatelessWidget {
  static const String routeName = 'view_personal_appointment_screen';
  final List<Employee> employees;
  ViewPersonalAppointmentScreen({@required this.employees});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalAppointmentBloc(employees: employees),
      child: PersonalAppointmentBody(),
    );
  }
}

class PersonalAppointmentBody extends StatefulWidget {
  @override
  _PersonalAppointmentBodyState createState() =>
      _PersonalAppointmentBodyState();
}

class _PersonalAppointmentBodyState extends State<PersonalAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  List<Employee> _employees;
  List<PersonalAppointment> _appointments;
  List<PersonalClient> _personalClients;
  DateTime _selectedDate;
  Employee _selectedEmployee;
  PersonalAppointment _selectedAppointment;
  PersonalClient _selectedClient;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    _employees = BlocProvider.of<PersonalAppointmentBloc>(context).employees;
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Appointments"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToDashboardScreen(context);
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (selectedIndex == null) {
                        infoDialogAlert("Please select an appointment");
                      } else {
                        print("send confirmation message");
                      }
                    },
                    child: Text("Text Confirmation to Record"),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.delete_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (selectedIndex == null) {
                          infoDialogAlert("Please select an appointment");
                        } else {
                          warningDialogAlert(
                              "Are you sure to delete that record ?",
                              _selectedAppointment.getAppointmentID());
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green[300],
                      ),
                      onPressed: () {
                        if (selectedIndex == null) {
                          infoDialogAlert("Please select an appointment");
                        } else {
                          navigateToUpdatePersonalAppointmentScreen(context);
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        navigateToAddAppointmentScreen(context);
                      }),
                ],
              ),
            ],
          ),
        )
      ],
      body: Column(
        children: [
          _viewPersonalAppointmentUI(),
          BlocListener<PersonalAppointmentBloc, PersonalAppointmentState>(
            listener: (context, state) {
              if (state is PersonalAppointmentDeletedSuccessfully) {
                successDialogAlert("Record deleted successfully");
              }
            },
            child:
                BlocBuilder<PersonalAppointmentBloc, PersonalAppointmentState>(
              builder: (context, state) {
                if (state is PersonalAppointmentInitial) {
                  return Container();
                } else if (state is GetPersonalAppointmentDataState) {
                  _appointments = state.appointments;
                  _personalClients = state.clients;
                  return SingleChildScrollView(
                      child: _appointmentListViewBuilder());
                } else if (state is NoPersonalAppointmentBookedState) {
                  return Center(
                    child: Text("No Appointment Booked"),
                  );
                } else if (state is PersonalAppointmentLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentListViewBuilder() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _appointments.length,
          itemBuilder: (context, index) {
            return _appointmentUI(
                _appointments[index], _personalClients[index], index);
          }),
    );
  }

  Widget _appointmentUI(PersonalAppointment personalAppointment,
      PersonalClient client, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedAppointment = personalAppointment;
            _selectedClient = client;
            selectedIndex = index;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.blue[50] : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Client : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          client.getLastName() +
                              "," +
                              " " +
                              client.getFirstName(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phone : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          client.getPhone(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Confirmed : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          personalAppointment.getStatus() == false
                              ? "No"
                              : "Yes",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          DateFormat.jm()
                              .format(personalAppointment.getAppointmentTime()),
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewPersonalAppointmentUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            DropdownSearch<Employee>(
              showSearchBox: true,
              dropdownSearchDecoration: InputDecoration(
                  hintText: "Search by employee name",
                  contentPadding: EdgeInsets.all(0.0)),
              searchBoxDecoration:
                  InputDecoration(hintText: "Search by employee name"),
              items: _employees,
              selectedItem: _selectedEmployee,
              itemAsString: (Employee u) => u.getEmployeeName(),
              onChanged: (Employee data) {
                _selectedEmployee = data;
                if (_dateController.text.isNotEmpty) {
                  BlocProvider.of<PersonalAppointmentBloc>(context).add(
                      GetPersonalAppointmentDataEvent(
                          employeeID: _selectedEmployee.getEmployeeID(),
                          date: _selectedDate));
                  selectedIndex = null;
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              controller: _dateController,
              onChanged: (value) {
                print(value);
              },
              onTap: () async {
                if (_selectedDate == null) {
                  _selectedDate = DateTime.now();
                }
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now().add(Duration(days: 365)));
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    _dateController.text =
                        DateFormat.yMd().format(_selectedDate);
                    if (_selectedEmployee != null) {
                      BlocProvider.of<PersonalAppointmentBloc>(context).add(
                          GetPersonalAppointmentDataEvent(
                              employeeID: _selectedEmployee.getEmployeeID(),
                              date: _selectedDate));
                      selectedIndex = null;
                    }
                  });
                }
              },
              decoration: InputDecoration(hintText: "Select Date"),
              readOnly: true,
            )
          ],
        ),
      ),
    );
  }

  void navigateToAddAppointmentScreen(BuildContext context) {
    Navigator.pushNamed(context, AddPersonalAppointmentScreen.routeName);
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void navigateToUpdatePersonalAppointmentScreen(BuildContext context) {
    List list = List();
    list.add(_selectedEmployee);
    list.add(_selectedAppointment);
    list.add(_selectedClient);
    final args = list;
    Navigator.pushReplacementNamed(
        context, UpdatePersonalAppointmentScreen.routeName,
        arguments: args);
  }

  successDialogAlert(String message) async {
    await Alert(
      context: context,
      type: AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      BlocProvider.of<PersonalAppointmentBloc>(context).add(
          GetPersonalAppointmentDataEvent(
              employeeID: _selectedEmployee.getEmployeeID(),
              date: _selectedDate));
    });
  }

  warningDialogAlert(String message, String appointmentID) async {
    await Alert(
      context: context,
      type: AlertType.warning,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<PersonalAppointmentBloc>(context).add(
                DeletePersonalAppointmentEvent(appointmentID: appointmentID));
            selectedIndex = null;
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        ),
      ],
    ).show().then((value) {});
  }

  infoDialogAlert(String message) async {
    await Alert(
      context: context,
      type: AlertType.info,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show().then((value) {});
  }
}
