/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/DriverBottomNavigationBar.dart';
import 'package:rt_final_project/view/driverDashboard/DisplayManagersUpdatesPage.dart';
import 'main.dart';

/// This class ManagersUpdatesData takes String date, String message and bool
/// isSeen as 3 parameters and stores them as an object so that the information
/// is all encapsulated. The ManagersUpdatesData object will be called when we
/// need to display all the information.
class ManagersUpdatesData {
  ManagersUpdatesData(
      {required this.date, required this.message, required this.isSeen});

  final String date;
  final String message;
  final bool isSeen;
}

/// This class ManagersUpdatesPage is the main Widget for the Manager's Updates
/// feature. It has a function _numberOfUnseenUpdates(List<DocumentSnapshot> docs)
/// to calculate the number of unseen messages, and uses a StreamBuilder and
/// snapshot to get data from the database. We use DisplayManagersUpdatesPage
/// Widget to separate concerns of Model and View.
class ManagersUpdatesPage extends StatelessWidget {
  const ManagersUpdatesPage({super.key, required this.title});

  final String title;

  /// This function _numberOfUnseenUpdates takes List<DocumentSnapshot> docs as
  /// a parameter. It iterates through the list and counts the number of unseen
  /// messages, that is, which docs have bool isSeen == false. It returns an int
  /// which is then passed to the UI Widget to display on screen.
  int _numberOfUnseenUpdates(List<DocumentSnapshot> docs) {
    int number = 0;
    for (var doc in docs) {
      if (doc['isSeen'] == false) {
        number++;
      }
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    String driverId = Provider.of<EmployeeInfo>(context).id;
    String driverName = Provider.of<EmployeeInfo>(context).name;
    String driverFamily = Provider.of<EmployeeInfo>(context).family;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, 'DriverDashboard');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Manager Updates"),

                /// This Text widget will display the driver's name and family name.
                Text("$driverName $driverFamily",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),

          /// We use a StreamBuilder to get the stream and snapshot from the database
          body: StreamBuilder<QuerySnapshot>(
            /// We select the 'managersUpdates' collection
            stream: FirebaseFirestore.instance
                .collection("managersUpdates")
                .snapshots(),

            /// We build the return Widget.
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              /// Here we get String date, String message, and bool isSeen from
              /// each document in the collection, store them in an instance of
              /// ManagersUpdatesData, and map them to a list for easy display in
              /// the UI.
              List<ManagersUpdatesData> managersUpdatesData = snapshot
                  .data!.docs
                  .map((doc) => ManagersUpdatesData(
                      date: doc['date'],
                      message: doc['message'],
                      isSeen: doc['isSeen']))
                  .toList();

              /// We get the number of unseen messages from the database by
              /// using the above function.
              var numberOfUnseenUpdates =
                  _numberOfUnseenUpdates(snapshot.data!.docs);

              /// We return the UI Widget with the List, int, and snapshot passed.
              return DisplayManagersUpdatesPage(
                managersUpdatesData: managersUpdatesData,
                numberOfUnseenUpdates: numberOfUnseenUpdates,
                snapshot: snapshot,
              );
            },
          ),
          bottomNavigationBar: DriverBottomNavigationBar(),
        ));
  }
}
