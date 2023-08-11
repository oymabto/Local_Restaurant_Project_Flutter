/// Done by Ian

import 'package:flutter/material.dart';

/// This class DisplayMyCustomerReviewsBody is a StatelessWidget that is responsible
/// for displaying the information passed to it to the My Customer's Reviews card.
/// We pass a num averageRating, num average, and String message as parameters to
/// be shown. It is a Column() with 2 Text()s inside where we pass the 3 values.
class DisplayMyCustomerReviewsBody extends StatelessWidget {
  const DisplayMyCustomerReviewsBody(
      {super.key,
      required this.averageRating,
      required this.average,
      required this.message});

  /// Changed to num because error. Fixed: https://stackoverflow.com/questions/58986585/type-int-is-not-a-subtype-of-type-double
  final num averageRating;
  final num average;
  final String message;

  @override
  Widget build(BuildContext context) {
    /// Main layout is a column.
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          /// Center the averageRating
            child: Text(
          "$averageRating",
          style: const TextStyle(fontSize: 24),
        )),
        /// Provide spacing between the 2 Text()s.
        const Padding(padding: EdgeInsets.all(8.0)),
        /// Display the average, a few spaces, and then the message.
        Text(
          "$average   $message",
          style: const TextStyle(fontSize: 18),
          /// Force maximum number of lines to be 2.
          maxLines: 2,
          /// Make any overflow end with an ellipsis (...).
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}