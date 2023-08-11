/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rt_final_project/view/driverDashboard/DisplayManagersUpdatesBody.dart';

/// This class ManagersUpdatesBody is a StatelessWidget that is the content of
/// the Manager's Updates card. It contains two functions, _numberOfUnseenUpdates
/// that counts the number of manager's updates that are not seen by the driver,
/// and getViewModelData that collects the data to display in the card body. The
/// class has a StreamBuilder to get information from the database. We read all
/// posts in the Manager's Updates, and can update each post individually so that
/// the manager knows the driver has seen them. We then pass information and a
/// snapshot to a display UI Widget.
class ManagersUpdatesBody extends StatelessWidget {
  const ManagersUpdatesBody({super.key});

  /// This function _numberOfUnseenUpdates takes List<DocumentSnapshot> docs as
  /// a parameter and returns an int number. This number is the number of posts
  /// that the driver has not updated as seen. We do this by iterating through
  /// docs and increasing a counter everytime the bool isSeen in the database is
  /// false. This function is important for the XX unseen messages feature in the
  /// Manager's Updates Card and Page.
  int _numberOfUnseenUpdates(List<DocumentSnapshot> docs) {
    /// Start the number at 0.
    int number = 0;
    /// Go through the docs and increase the number if it's bool isSeen is false.
    for (var doc in docs) {
      if (doc['isSeen'] == false) {
        number++;
      }
    }
    return number;
  }

  /// This function getViewModelData takes docs as a parameter and assigns values
  /// to String date, String message, int numberOfUnseenUpdates, the three
  /// variables we want to display in the card UI. We do this with docs as it is
  /// a stream snapshot from the database. The posted date and message are
  /// assigned, and the number of unseen messages is computed from the latest
  /// data. We get the latest post by finding the latestIndex, which is the length
  /// of docs (the List of all documents in the collection) minus 1. We return
  /// the three vars as a 3-tuple.
  (String, String, int) getViewModelData(docs) {
    /// The last index is the length minus 1.
    var lastIndex = docs.length - 1;

    /// Get the last documents date
    var date = docs[lastIndex]['date'];
    /// Get the last documents message
    var message = docs[lastIndex]['message'];
    /// Get the number of unseen updates
    var numberOfUnseenUpdates = _numberOfUnseenUpdates(docs);
    /// Return them as a 3-tuple.
    return (date, message, numberOfUnseenUpdates);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      /// We select the collection 'managersUpdates'
        stream: FirebaseFirestore.instance
            .collection("managersUpdates")
            .snapshots(),
        /// We build the Widget to return, passing a context, and snapshot.
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          /// If there is an error when connecting to the database, show an error
          /// message.
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          /// While the data is loading, show a loading message
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          /// Set the values of date, message, and unseen updates with the use of
          /// the getViewModelData() function by passing the correct snapshot.
          final (date, message, numberOfUnseenUpdates) = getViewModelData(snapshot.data!.docs);
          /// Use a Widget to display all the information in the UI, keeping with
          /// separation of concerns.
          return DisplayManagersUpdatesBody(date: date, message: message, numberOfUnseenUpdates: numberOfUnseenUpdates);
        });
  }
}