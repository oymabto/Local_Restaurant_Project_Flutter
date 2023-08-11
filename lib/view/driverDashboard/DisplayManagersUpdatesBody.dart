/// Done by Ian

import 'package:flutter/material.dart';

/// This class DisplayManagersUpdatesBody is a StatelessWidget that is responsible
/// for displaying the information passed to it in the Manager's Updates card.
/// We pass a String date, String message, and int numberOfUnseenUpdates to it.
/// It is a Column() of Text()s to display the information nicely. We have a
/// ternary operator that will show either a message containing the number of
/// unseen messages or nothing in its place if there are no unseen messages.
class DisplayManagersUpdatesBody extends StatelessWidget {
  const DisplayManagersUpdatesBody(
      {super.key,
      required this.date,
      required this.message,
      required this.numberOfUnseenUpdates});
  final String date;
  final String message;
  final int numberOfUnseenUpdates;

  @override
  Widget build(BuildContext context) {
    /// The layout is vertical.
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// If there are unseen updates then we show an unseen messages
          /// message letting the user know how many messages have not been seen.
          /// Otherwise if there are no messages we show nothing (a padding of
          /// size 0).
          (numberOfUnseenUpdates != 0)
          /// Show the number of messages not seen.
              ? Text("$numberOfUnseenUpdates unseen messages")
          /// Show nothing.
              : const Padding(padding: EdgeInsets.all(0.0)),
          /// Show the date the message was created.
          Text("$date:", style: const TextStyle(fontSize: 18)),
          /// Space the Text()s.
          const SizedBox(
            height: 8.0,
          ),
          /// Show the first 2 lines of the message and remove overflow with an
          /// ellipsis (...).
          Text(
            message,
            style: const TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ]);
  }
}