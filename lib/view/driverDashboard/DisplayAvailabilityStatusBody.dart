/// Done by Ian

import 'package:flutter/material.dart';

/// This class DisplayAvailabilityStatusBody is a StatelessWidget that displays
/// the UI for the AvailabilityStatus card. It takes a bool isDriverAvailable,
/// and an AsyncSnapshot snapshot as parameters. As a UI Widget, it will take
/// parameters and display them. The snapshot is needed because we are updating
/// a field in the database with the click of a button, so we need the stream.
/// The UI is a Column() with a TextButton() that changes label depending on the
/// bool passed, which has the value same as the one in the database. The button
/// toggles the bool value from true to false and vice versa (as well as the
/// value in the database). The color of the text also changes from red to green
/// depending on the availability. When the button is pressed, the database is
/// updated.
class DisplayAvailabilityStatusBody extends StatelessWidget {
  const DisplayAvailabilityStatusBody({super.key,
    required this.isDriverAvailable,
    required this.snapshot});
  final bool isDriverAvailable;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    /// Center the button.
    return Center(
        child: Expanded(
            child: Container(
              /// Make the button the width of the parent.
                width: MediaQuery.of(context).size.width,
                /// Make the height of the button large so it is easy to press.
                height: MediaQuery.of(context).size.height / 11,
                /// Create the text button.
                child: TextButton(
                  /// Set the style of the button.
                  style: ButtonStyle(
                    /// Add padding to the button.
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(10.0))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Depending on the value of isDriverAvailable, we will
                        /// show Available in green, or Not Available in red using
                        /// the ternary operator.
                        (isDriverAvailable)
                            ? const Text("Available",
                            style: TextStyle(
                                fontSize: 24, color: Colors.green))
                            : const Text("Not Available",
                            style: TextStyle(
                                fontSize: 24, color: Colors.red)),
                      ]),
                  /// When the button is pressed we perform the following: toggle
                  /// the bool in the database by setting the bool to its opposite
                  /// value each time.
                  onPressed: () {
                    snapshot.data!.docs.first.reference.update({
                      'availability':
                      !snapshot.data!.docs.first['availability']
                    });
                  },
                ))));
  }
}