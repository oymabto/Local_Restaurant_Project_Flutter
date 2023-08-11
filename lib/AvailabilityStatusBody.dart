/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/driverDashboard/DisplayAvailabilityStatusBody.dart';
import 'main.dart';

/// This class is a StatelessWidget that is the body of the
/// AvailabilityStatusCard. It contains StreamBuilder to get `availability`
/// from the `drivers` collection in the Firestore database. We use snapshot to
/// get the information form the database. Inside the StreamBuilder we have a
/// GestureDetector to allow the user to change availability by onTap.
///
/// The state of availability will toggle on and off in the database, and client-
/// side for each onTap.
///
/// This Widget contains the UI and functionality of the body of the Card.
class AvailabilityStatusBody extends StatelessWidget {
  const AvailabilityStatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    String driverId = Provider.of<EmployeeInfo>(context).id;

    /// StreamBuilder allows us to take a snapshot of a stream from our database.
    /// Here, we are interested in the drivers collection as we will change the
    /// availability status of the driver that is logged in.
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("drivers")
            .where("id", isEqualTo: driverId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          /// If there is an error with the connection to the database, show an
          /// error message in a Text().
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          /// If there is a connection, but we are waiting on receving all the
          /// information, show a loading Text().
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          /// Get the availability of the driver and set it to a local bool. This
          /// bool will be passed to the body of the card, and updated.
          bool isDriverAvailable = snapshot.data!.docs.first['availability'];
          /// This is the content of the availability card being displayed, we
          /// pass the bool and the snapshot to be able to update with the UI
          /// button.
          return DisplayAvailabilityStatusBody(
            isDriverAvailable: isDriverAvailable,
            snapshot: snapshot,
          );
        });
  }
}