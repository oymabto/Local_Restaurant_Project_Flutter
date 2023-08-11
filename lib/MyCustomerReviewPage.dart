/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/DriverBottomNavigationBar.dart';
import 'package:rt_final_project/view/driverDashboard/DisplayMyCustomerReviewsPage.dart';
import 'main.dart';

/// This class ReviewData takes 2 parameters String message and num rating, so
/// that they are encapsulated when passing them to be displayed in the UI Widget
class ReviewData {
  ReviewData({required this.message, required this.rating});

  final String message;
  final num rating;
}

/// This class MyCustomerReviewPage is a StatelessWidget that is the screen for
/// My Customer Reviews for the logged in driver. It has an averageRatingForDriver
/// function that takes the collection documents and outputs the arverageRating.
/// It is a StreamBuilder that collects documents from the customerReviews
/// collections and passes the information to a display Widget.
class MyCustomerReviewPage extends StatelessWidget {
  const MyCustomerReviewPage({super.key, required this.title});

  final String title;

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
      numerator += doc['rating'];
    }

    /// Learned about .floor() here: https://www.educative.io/answers/what-is-the-floor-function-in-dart
    num averageRating = ((numerator / denominator * 10).floor() / 10);
    return averageRating;
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
                const Text("Customer Review"),

                /// This Text widget will display the driver's name and family name.
                Text("$driverName $driverFamily",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            /// Get the stream from customerReviews, selected by the driverID of the
            /// logged in driver.
            stream: FirebaseFirestore.instance
                .collection('customerReviews')
                .where('driverID', isEqualTo: driverId)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              /// Since we are displaying all customer reviews, we map them into
              /// a List<ReviewData> so that all messages and ratings can be
              /// passed to the display Widget and displayed.
              List<ReviewData> reviewData = snapshot.data!.docs
                  .map((doc) => ReviewData(
                      message: doc['message'], rating: doc['rating']))
                  .toList();

              /// Get the averageRating.
              var averageRating = averageRatingForDriver(snapshot.data!.docs);

              /// Pass the information to display to the display Widget.
              return DisplayMyCustomerReviewsPage(
                reviewData: reviewData,
                averageRating: averageRating,
              );
            },
          ),
          bottomNavigationBar: DriverBottomNavigationBar(),
        ));
  }
}