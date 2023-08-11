/// Done by Ian

import 'package:flutter/material.dart';
import 'package:rt_final_project/ManagersUpdatesPage.dart';

/// This class DisplayManagersUpdatesPage is a StatelessWidget that will display
/// all the information passed to it for the Manager's Updates page. We pass a
/// List<ManagersUpdatesData> managersUpdatesData, an int numberOfUnseenUpdates,
/// and an AsyncSnapshot snapshot. managersUpdatesData encapsulates all of the
/// information about the manager's updates. We also pass the number of unseen
/// updates, and a snapshot so that we can update our database bool isSeen to
/// true to indicate that a message has been seen. The display is a Column()
/// that shows the number of unseen messages at the top, and a list of all the
/// manager's updates in reverse chronological order.
class DisplayManagersUpdatesPage extends StatelessWidget {
  const DisplayManagersUpdatesPage(
      {super.key,
      required this.managersUpdatesData,
      required this.numberOfUnseenUpdates,
      required this.snapshot});

  final List<ManagersUpdatesData> managersUpdatesData;
  final int numberOfUnseenUpdates;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    /// The main layout is a column.
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// If the number of updates is not 0, we show how many messages are
          /// unseen. Otherwise, we show nothing in it's place.
          (numberOfUnseenUpdates != 0)
              ? Text(
                  /// Show the message
                  "$numberOfUnseenUpdates unseen messages",
                  style: const TextStyle(fontSize: 18))
              /// Show nothing instead.
              : const Padding(padding: EdgeInsets.all(0.0)),
          Expanded(
              child: Container(
                /// Fix the width to 400
                  width: 400,
                  /// Create a ListView with .builder and pass each message that
                  /// can be clicked to change bool isSeen in the database to true.
                  child: ListView.builder(
                    /// The itemCount is the length of the list.
                    itemCount: managersUpdatesData.length,
                    /// Pass the context and index for each item.
                    itemBuilder: (context, index) {
                      /// Use a GestureDetector() to use onTap().
                      return GestureDetector(
                          onTap: () {
                            /// Present the list in reverse order, and update
                            /// the bool isSeen to true when the card is clicked.
                            snapshot
                                .data!
                                .docs[managersUpdatesData.length - 1 - index]
                                .reference
                                .update({'isSeen': true});
                          },
                          child: Card(
                            /// Change the color of the card from white to grey
                            /// to show that the button has been clicked.
                              color: (snapshot.data!.docs[
                                      managersUpdatesData.length -
                                          1 -
                                          index]['isSeen'])
                                  ? Colors.grey
                                  : Colors.white,
                              clipBehavior: Clip.antiAlias,
                              /// Add padding.
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  /// Present the data as a column of date over
                                  /// message.
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            /// snapshot.data!.docs.length - 1 - index
                                          /// makes the list latest first (reverse order).
                                          /// Display the date.
                                            "${managersUpdatesData[index].date}:",
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        const SizedBox(height: 8.0),
                                        /// Display the message.
                                        Text(
                                          managersUpdatesData[index].message,
                                          style: const TextStyle(fontSize: 18),
                                        )
                                      ]))));
                    },
                  )))
        ]);
  }
}
