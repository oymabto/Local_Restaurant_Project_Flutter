/// Done by Alireza

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CustomBottomNavigationBar.dart';
import 'DriverManagementScreen.dart';
import 'InventoryScreen.dart';
import 'ManagerDashboardBasicCard.dart';
import 'MenuScreen.dart';
import 'OrdersScreen.dart';
import 'main.dart';

/// ManagerDashboard is a screen that displays various options for managing
/// different aspects of a restaurant including orders, inventory, drivers, and menu.
class ManagerDashboard extends StatefulWidget {
  final String managerName;

  const ManagerDashboard({Key? key, required this.managerName})
      : super(key: key);

  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {

  /// _currentIndex keeps track of the selected tab in the bottom navigation bar.
  int _currentIndex = 0;

  /// This function updates the _currentIndex when a tab is selected.
  ///It uses setState to rebuild the widget with the new _currentIndex.
  void _handleTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<LoggedInState>(context).isLoggedIn;
    String managerName = Provider.of<EmployeeInfo>(context).name;
    String managerFamily = Provider.of<EmployeeInfo>(context).family;
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome $managerName $managerFamily"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ManagerDashboardBasicCard(
                    title: "Order Management",
                    imageUrl:
                        "https://i.postimg.cc/d7J4pZtG/order-svgrepo-com.png",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersScreen()));
                    },
                  ),
                  ManagerDashboardBasicCard(
                    title: "Inventory",
                    imageUrl:
                        "https://i.postimg.cc/t1D2jRYw/inventory-svgrepo-com.png",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InventoryScreen()));
                    },
                  ),
                  ManagerDashboardBasicCard(
                    title: "Driver Management",
                    imageUrl:
                        "https://i.postimg.cc/DSkCQY9j/scooter-delivery-food-svgrepo-com.png",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverManagementScreen()));
                    },
                  ),
                  ManagerDashboardBasicCard(
                    title: "Menu",
                    imageUrl:
                        "https://i.postimg.cc/ts3BBNyX/new-svgrepo-com.png",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          isLoggedIn: isLoggedIn,
          currentIndex: _currentIndex,
          onTabSelected: _handleTabSelected,
        ));
  }
}
