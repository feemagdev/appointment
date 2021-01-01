import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/bloc/view_employee_bloc/view_employee_bloc.dart';
import 'package:appointment/screens/add_employee_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewEmployeeScreen extends StatelessWidget {
  static const String routeName = 'view_employee_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewEmployeeBloc(),
      child: VeiwEmployeeBody(),
    );
  }
}

class VeiwEmployeeBody extends StatefulWidget {
  @override
  _VeiwEmployeeBodyState createState() => _VeiwEmployeeBodyState();
}

class _VeiwEmployeeBodyState extends State<VeiwEmployeeBody> {
  List<Employee> employees;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddEmployeeScreen(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Employees"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToDashboardScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<ViewEmployeeBloc, ViewEmployeeState>(
            listener: (context, state) {},
            child: BlocBuilder<ViewEmployeeBloc, ViewEmployeeState>(
              builder: (context, state) {
                if (state is ViewEmployeeInitial) {
                  BlocProvider.of<ViewEmployeeBloc>(context)
                      .add(GetEmployeesListEvent());
                  return Container();
                } else if (state is GetEmployeesListState) {
                  employees = state.employeesList;
                  return listOfEmployees();
                } else if (state is ViewEmployeeLoadingState) {
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

  Widget listOfEmployees() {
    return SingleChildScrollView(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        shrinkWrap: true,
        itemCount: employees.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              BlocProvider.of<ViewEmployeeBloc>(context)
                  .add(ViewSelectedEmployeeEvent(employee: employees[index]));
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      employees[index].getEmployeeName(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void navigateToAddEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AddEmployeeScreen.routeName);
  }
}
