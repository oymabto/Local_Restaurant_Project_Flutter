/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/view/driverDashboard/DisplayMyCustomerReviewsBody.dart';

import 'main.dart';

/// This class MyCustomerReviewsBody is a StatelessWidget that is the body of
/// the My Customer Reviews card. It has 2 functions averageRatingForDriver, and
/// getViewModelData to create and contain the information to be passed to the
/// UI Widget. We use a StreamBuilder to get access to the database, and use a
/// UI Widget to display the data.
class MyCustomerReviewsBody extends StatelessWidget {
  const MyCustomerReviewsBody({super.key});

  /// This function averageRatingForDriver takes docs as a parameter, and cycles
  /// through each document in the list, and adds all the ratings, setting it to
  /// num numerator. We then find the number of documents with docs.length and
  /// set it to the denominator. Dividing the two (numerator / denominator)
  /// yields num averageRating, which is returned. Note that we use num instead
  /// of int and double. The final num is multiplied by 10, floored, and then
  /// divided by 10 to round to the first decimal place.
  num averageRatingForDriver(docs) {
    num numerator = 0.0;
    num denominator = docs.length;
    for (var doc in docs) {
      numerator += (doc['rating'] as num);
    }
    num averageRating = ((numerator / denominator * 10.0).floor() / 10.0);
    return averageRating;
  }

  /// This function getViewModelData is used to encapsulate the data that will
  /// be passed to the display UI. It takes docs as a parameter and returns num
  /// averageRating, num average, and num message as a 3-tuple. averageRating is
  /// found with the above function, and average, and message are found by getting
  /// the corresponding data in the database. We find latestIndex which is
  /// docs.length - 1 to show the latest entry in the database.
  (num, num, String) getViewModelData(docs) {
    /// Get the averageRating
    num averageRating = averageRatingForDriver(docs);

    /// Get the last index
    var latestIndex = docs.length - 1;

    /// Get the latest rating
    num average = docs[latestIndex]['rating'];

    /// Get the latest message
    var message = docs[latestIndex]['message'];

    /// Return the 3 as a 3-tuple
    return (averageRating, average, message);
  }

  @override
  Widget build(BuildContext context) {
    /// Get the driverId of the logged in employee.
    String driverId = Provider.of<EmployeeInfo>(context).id;

    /// Use a StreamBuilder to get the data in the database and return a Widget.
    return StreamBuilder<QuerySnapshot>(

        /// We fetch the customer reviews for the particular driver.
        stream: FirebaseFirestore.instance
            .collection('customerReviews')
            .where('driverID', isEqualTo: driverId)
            .snapshots(),

        /// We build the Widget to return, using a context and snapshot.
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          /// If there is an error with the database connection, return an error
          /// message.
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          /// If we are waiting on the database, show a loading message.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          /// Get the 3 values, and encapsulate them with the function above
          /// in a 3-tuple.
          final (averageRating, average, message) =
              getViewModelData(snapshot.data!.docs);

          /// Pass averageRating, average, and message to the UI display Widget.
          return DisplayMyCustomerReviewsBody(
              averageRating: averageRating, average: average, message: message);
        });
  }
}
