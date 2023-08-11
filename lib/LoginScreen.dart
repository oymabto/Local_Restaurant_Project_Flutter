/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DriverDashboard.dart';
import 'LoginDialog.dart';
import 'CustomBottomNavigationBar.dart';
import 'ManagerDashboard.dart';
import 'main.dart'; // Import the file where LoggedInState is defined.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final int _currentIndex = 0;
  void _handleLoginSuccess(String name, String family, String userType, String id) {
    Provider.of<LoggedInState>(context, listen: false).logIn();
    Provider.of<EmployeeInfo>(context, listen: false)
        .setInfo(name, family, userType, id);

    String username = "$name $family";

    if (userType == 'manager') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ManagerDashboard(managerName: username),
      ));
    } else if (userType == 'driver') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DriverDashboard(title: "hi", username: username,),
      ));
    }
  }

  void _handleTabSelected(int index) {}

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<LoggedInState>(context).isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytes on Bikes Employee Dashboard'),
      ),
      body: Center(
        child: isLoggedIn
            ? const Text('User Logged In') // Content after logging in
            : LoginDialog(
                onLoginSuccess: (name, family, userType, id) =>
                    _handleLoginSuccess(name, family, userType, id),
              ),
      ),
    );
  }
}
