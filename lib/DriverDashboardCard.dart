/// Done by Ian

import 'package:flutter/material.dart';

/// This class DriverDashboardCard is a StatelessWidget that takes 2 parameters:
/// String title, and Widget bodyWidget. The class is a UI Widget for displaying
/// content only. It is wrapped in GestureDetector() in the class where it is
/// called. The class contains a Container() wrapping a Card(), with Padding(),
/// that has a Column() of Center()ed Text() that holds the title, and Padding()
/// around the bodyWidget.
class DriverDashboardCard extends StatelessWidget {
  const DriverDashboardCard(
      {super.key, required this.title, required this.bodyWidget});

  final String title;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    /// Use a Container() to fix the size to 300 width, 200 height.
    return Container(
      width: 300,
      height: 200,

      /// The Card() allows us to have a nice rectangular area to display
      /// information that is grouped.
      child: Card(
        clipBehavior: Clip.antiAlias,

        /// Add Padding() so it is pleasing on the eye.
        child: Padding(
            padding: const EdgeInsets.all(16.0),

            /// The main layout is a Column()
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Center() the title, and make it big.
                  Center(
                      child: Text(title, style: const TextStyle(fontSize: 24))),

                  /// Add some space between the title and bodyWdiget.
                  const Padding(padding: EdgeInsets.all(8.0)),
                  bodyWidget
                ])),
      ),
    );
  }
}
