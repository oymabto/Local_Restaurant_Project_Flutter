/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/AvailabilityStatusBody.dart';
import 'package:rt_final_project/ManagersUpdatesBody.dart';
import 'package:rt_final_project/MyCustomerReviewsBody.dart';
import 'CurrentDeliveryBody.dart';
import 'DriverBottomNavigationBar.dart';
import 'DriverDashboardCard.dart';
import 'main.dart';

/// For Windows: To be able to use flutter init, use the following in the terminal:
/// To run scripts: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

/// This class DriverDashboard is a StatelessWidget that is the main page for
/// a driver employee. It contains a Column() that has 4 DriverDashboardCard()s.
/// These cards are UI Widgets wrapped in a GestureDetector() so that onTap()
/// will take you to the corresponding screen.
class DriverDashboard extends StatelessWidget {
  String username;

  DriverDashboard({Key? key, required String title, required this.username})
      : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get title => "Driver Dashboard";

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<LoggedInState>(context).isLoggedIn;
    String driverName = Provider.of<EmployeeInfo>(context).name;
    String driverFamily = Provider.of<EmployeeInfo>(context).family;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $driverName $driverFamily"),
      ),

      /// The body of the Scaffold()
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            /// The layout is a single column of cards.
            child: Column(
              /// The GestureDetector() allows onTap() to push the user to the
              /// correct screen with named routes in main.dart.
              children: [
                /// Each DriverDashboardCard() will use a different database, so
                /// bodyWidget is a good design.
                GestureDetector(
                  /// DriverDashboardCard() is a UI Widget that takes a String title
                  /// and a Widget bodyWidget. Each DriverDashboardCard() will use a
                  /// different database, so bodyWidget is a good design. It allows
                  /// us to separate title, and content of each card, both which
                  /// will change from card to card.
                  child: const DriverDashboardCard(

                      /// Pass the title of the card, which is a String.
                      title: "Current Delivery",

                      /// Pass the body of the card, which is a Widget.
                      bodyWidget: CurrentDeliveryBody()),
                  onTap: () {
                    /// Remove the current screen, so that we do not add running
                    /// screens that we are not using.
                    Navigator.pop(context);

                    /// Create the new screen, such that it is the only screen running.
                    Navigator.pushNamed(context, 'CurrentDelivery');
                  },
                ),
                const DriverDashboardCard(
                  title: "Availability Status",
                  bodyWidget: AvailabilityStatusBody(),
                ),
                GestureDetector(
                    child: const DriverDashboardCard(
                      title: "My Customer Reviews",
                      bodyWidget: MyCustomerReviewsBody(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'MyCustomerReviews');
                    }),
                GestureDetector(
                    child: const DriverDashboardCard(
                      title: "Manager's Updates",
                      bodyWidget: ManagersUpdatesBody(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'ManagersUpdates');
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const DriverBottomNavigationBar(),
    );
  }
}