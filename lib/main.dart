import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/LoginScreen.dart';
import 'package:rt_final_project/firebase_options.dart';
import 'CurrentDeliveryPage.dart';
import 'DriverDashboard.dart';
import 'DriverSettingsPage.dart';
import 'ManagersUpdatesPage.dart';
import 'MyCustomerReviewPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class LoggedInState extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  /// Sets _isLoggedIn to true to indicate that the user is logged in.
  /// Notifies all its listeners about this change.
  void logIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  /// Sets _isLoggedIn to false to indicate that the user is logged out.
  /// Notifies all its listeners about this change.
  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

/// EmployeeInfo holds the information about an employee.
class EmployeeInfo extends ChangeNotifier {
  String _name = "";
  String _family = "";
  String _userType = "";
  String _id = "";

  String get name => _name;
  String get family => _family;
  String get userType => _userType;
  String get id => _id;

  /// Sets the values of employee information fields.
  /// Notifies all its listeners about this change.
  void setInfo(String name, String family, String userType, String id) {
    _name = name;
    _family = family;
    _userType = userType;
    _id = id;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// This widget is the root of your application..
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoggedInState()),
        ChangeNotifierProvider(create: (context) => EmployeeInfo()),
      ],
      child: MaterialApp(
        title: 'Bytes on Bikes final project',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          'Login': (BuildContext context) => LoginScreen(),
          'DriverDashboard': (BuildContext context) =>
              DriverDashboard(title: "Dd", username: "",),
          'CurrentDelivery': (BuildContext context) =>
              const CurrentDeliveryPage(title: "Current Delivery"),
          'MyCustomerReviews': (BuildContext context) =>
              const MyCustomerReviewPage(title: "My Customer Reviews"),
          'ManagersUpdates': (BuildContext context) =>
              const ManagersUpdatesPage(title: "Manager's Updates"),
          'DriverSettings': (BuildContext context) =>
              const DriverSettingsPage(title: "About Us")
        },

        /// Setting the home page of the app, which is LoginScreen.
        home: LoginScreen(),
      ),
    );
  }
}