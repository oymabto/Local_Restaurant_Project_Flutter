/// Devin Oxman

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/DriverManagementListMessages.dart';
import 'DriverManagementListDrivers.dart';
import 'main.dart';


/// Class which calls the private class which hosts the tabbed interface for drivers and messages
class DriverManagementScreen extends StatefulWidget {
  @override
  _DriverManagementScreenState createState() => _DriverManagementScreenState();
}

/// Build a tabbed interface so the manager can edit drivers and messages
/// Using material tabbed interface
///https://api.flutter.dev/flutter/material/TabController-class.html
class _DriverManagementScreenState extends State<DriverManagementScreen> with SingleTickerProviderStateMixin {
  static const List<Tab> driverManagementTabs = <Tab>[
    Tab(text: 'Drivers'),
    Tab(text: 'Messages'),
  ];
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String managerName = Provider.of<EmployeeInfo>(context).name;
    String managerFamily = Provider.of<EmployeeInfo>(context).family;
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Management $managerName $managerFamily"),
        bottom: TabBar(
          controller: _tabController,
          tabs: driverManagementTabs,
        ),
      ),
      //the body holds the tabbs and tab-bar
      body: TabBarView(
        controller: _tabController,
        children: [
          //build drivers list
          DriverManagementListDrivers(),
          // build messages list
          DriverManagementListMessages(),
        ],
      ),
    );
  }
}