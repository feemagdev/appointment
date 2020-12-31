import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/bloc/view_personal_appointment_bloc/personal_appointment_bloc.dart';
import 'package:appointment/screens/add_personal_appointment_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  List<Employee> employees;
  DateTime selectedDate;
  Employee selectedEmployee;

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigateToAddAppointmentScreen(context);
          }),
      body: Stack(
        children: [
          BlocListener<PersonalAppointmentBloc, PersonalAppointmentState>(
            listener: (context, state) {},
            child:
                BlocBuilder<PersonalAppointmentBloc, PersonalAppointmentState>(
              builder: (context, state) {
                if (state is PersonalAppointmentInitial) {
                  employees = state.employees;
                  return _viewPersonalAppointmentUI();
                }
                return Container();
              },
            ),
          ),
        ],
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
              items: employees,
              selectedItem: selectedEmployee,
              itemAsString: (Employee u) => u.getEmployeeName(),
              onChanged: (Employee data) {
                selectedEmployee = data;
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
                if (selectedDate == null) {
                  selectedDate = DateTime.now();
                }
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now());
                if (picked != null)
                  setState(() {
                    selectedDate = picked;
                    _dateController.text =
                        DateFormat.yMd().format(selectedDate);
                    print(_dateController.text);
                  });
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
}
