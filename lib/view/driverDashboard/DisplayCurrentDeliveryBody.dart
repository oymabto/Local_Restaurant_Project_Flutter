/// Done by Ian

import 'package:flutter/material.dart';

/// This class DisplayCurrentDeliveryBody is a StatelessWidget that is
/// responsible for displaying the values passed to the Widget on the Current
/// Delivery card. We pass String orderNumber, String streetAddress, and String
/// cityAddress, so that the driver logged in can see the information at a
/// glance. It is a simple Column() with 2 Text().
class DisplayCurrentDeliveryBody extends StatelessWidget {
  const DisplayCurrentDeliveryBody({super.key,
  required this.orderNumber,
  required this.streetAddress,
  required this.cityAddress});
  final String orderNumber;
  final String streetAddress;
  final String cityAddress;

  @override
  Widget build(BuildContext context) {
    /// Center the Text()s
    return Center(
      /// Have them ordered vertically.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Display the orderNumber
            Text("# $orderNumber", style: const TextStyle(fontSize: 24)),
            /// Separate the two Text()s
            const SizedBox(height: 16.0),
            /// Display the address on 2 lines.
            Text("$streetAddress\n$cityAddress",
                style: const TextStyle(fontSize: 18)),
          ],
        ));
  }
}
