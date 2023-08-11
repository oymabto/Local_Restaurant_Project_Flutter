/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/view/driverDashboard/DisplayCurrentDeliveryBody.dart';

import 'main.dart';

/// This class CurrentDeliveryBody is a StatelessWidget is the Widget responsible
/// for the Current Delivery Card body. It is passed as a bodyWidget, collects
/// all the information to be shown with (String, String, String) getViewModelData(docs)
/// build the connection to the database with StreamBuilder(), and then passes
/// information to the display Widget to display  the data. In case there is an
/// error connecting to the database, or there is a long load time, we have
/// messages that will display an appropriate message. When the connection is made
/// we pass the data to the display Widget.
class CurrentDeliveryBody extends StatelessWidget {
  const CurrentDeliveryBody({super.key});

  /// This function getViewModelData(docs) encapsulates the data we want to show
  /// on the Curren Delivery Card. We pass the snapshot document list docs to the
  /// function, and return a 3-tuple that contains String orderNumber, String
  /// streetAddress, and String cityAddress. docs.first is used since there is
  /// only 1 collection of documents found in our query, so we are sure which one
  /// we have. orderNumber is the same as the id which is created as the length
  /// of the list plus 1. streetAddress is pulled from the database, and so is
  /// cityAddress.
  (String, String, String) getViewModelData(docs) {
    var orderNumber = docs.first.id;
    var streetAddress = docs.first['streetAddress'];
    var cityAddress = docs.first['cityAddress'];
    return (orderNumber, streetAddress, cityAddress);
  }

  @override
  Widget build(BuildContext context) {
    /// driverId is taken from the logged in driver user, and used as the
    /// selection parameter in the database (it is designed so that they are the
    /// same).
    String driverId = Provider.of<EmployeeInfo>(context).id;

    return StreamBuilder<QuerySnapshot>(

        /// In the orders collection, we select orders where driverID is the
        /// logged in driver's id, isBeingDelivered is true, and isDelivered is
        /// false. These are the conditions such that the order is prepared,
        /// being delivered, and not delivered yet for the corresponding driver.
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('driverID', isEqualTo: driverId)
            .where('isBeingDelivered', isEqualTo: true)
            .where('isDelivered', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          /// If there is an error, we return an error message.
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          /// If the connection is loading, we return a waiting message.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          /// Figure out how to have no data pulled from here:
          /// https://stackoverflow.com/questions/60989203/flutter-how-to-show-a-message-if-snapshot-has-no-data
          /// If there is no data, display a CircularProgressIndicator().
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();

            /// If there is data, but it is empty, show no current delivery message.
          } else if (snapshot.hasData && snapshot.data?.size == 0) {
            return const Center(child: Text("No current delivery"));

            /// Otherwise, if there is data, get the variables, and pass them to
            /// the UI Widget.
          } else {
            final (orderNumber, streetAddress, cityAddress) =
                getViewModelData(snapshot.data!.docs);
            return DisplayCurrentDeliveryBody(
                orderNumber: orderNumber,
                streetAddress: streetAddress,
                cityAddress: cityAddress);
          }
        });
  }
}
