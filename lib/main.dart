import 'package:appointment/api/api.dart';
import 'package:appointment/route_generator.dart';
import 'package:appointment/screens/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[700],
      statusBarIconBrightness: Brightness.dark));
  // await Firebase.initializeApp();
  Api api = Api();
  bool check = await api.getApiToken();

  if (check) {
    runApp(MyApp());
  } else {
    runApp(FailedApp());
  }
}

class FailedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appointment Confirmation',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        primaryColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Proxima',
      ),
      home: Scaffold(
        backgroundColor: Colors.blue[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/broken-robot.png',
                scale: 1,
              ),
              Text(
                "Authentication Error\nPlease close the app",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: DashboardScreen.routeName,
      title: 'Appointment Confirmation',
      theme: ThemeData(
        primaryColor: Colors.blue[700],
        primaryColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Proxima',
      ),
    );
  }
}
