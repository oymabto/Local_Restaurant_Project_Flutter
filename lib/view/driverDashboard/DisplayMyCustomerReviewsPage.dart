/// Done by Ian

import 'package:flutter/material.dart';

import '../../MyCustomerReviewPage.dart';

/// This class DisplayMyCustomerReviewsPage is a StatelessWidget that will show
/// the information passed to it in the My Customer Reviews page. We pass a
/// List<ReviewData> reviewData, and a num averageRating. reviewData is an
/// object made to encapsulate the data that is to be displayed: The date, and
/// message. The display is a Column() with a Text() showing the averageRating,
/// followed by a ListView.builder() which shows all the customer reviews for
/// that particular driver in the database. Each Card() is wrapped in a
/// GestureDetector() to allow onTap() to be used to change the bool isSeen to
/// false. We show the rating, and the message next to it for each review in the
/// database.
class DisplayMyCustomerReviewsPage extends StatelessWidget {
  const DisplayMyCustomerReviewsPage(
      {super.key, required this.reviewData, required this.averageRating});

  final List<ReviewData> reviewData;
  final num averageRating;

  @override
  Widget build(BuildContext context) {
    /// Main layout is vertical.
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Show the average rating at the top.
          Text(
            "$averageRating Average Rating",
            style: const TextStyle(fontSize: 24),
          ),

          /// Learned about Expanded() here: https://www.flutterbeads.com/wrap_content-and-match_parent-for-the-container-in-flutter/
          Expanded(
              child: Container(
                  width: 400,
                  /// Build a ListView with .build().
                  child: ListView.builder(
                    /// The itemCount is the length of the collection in the database.
                      itemCount: reviewData.length,
                      itemBuilder: (context, index) {
                        /// Use GestureDetector() for onTap().
                        return GestureDetector(
                            onTap: () {},
                            /// Pass a Card() so that each item is in a card.
                            child: Card(
                                clipBehavior: Clip.antiAlias,
                                /// Add padding to make it look nice.
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      /// Use a Row() for a horizontal layout
                                      /// for each Card().
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// Show the rating
                                          Text(
                                            "${reviewData[reviewData.length - 1 - index].rating}",
                                            style:
                                                const TextStyle(fontSize: 24.0),
                                          ),
                                          /// Put some spacing between rating
                                          /// and message.
                                          const SizedBox(width: 20),
                                          /// Control the width of the Row() with Flexible().
                                          /// Used the following source: https://stackoverflow.com/questions/45986093/textfield-inside-of-row-causes-layout-exception-unable-to-calculate-size/45990477#45990477
                                          Flexible(
                                            /// Display the message.
                                            child: Text(reviewData[
                                                    reviewData.length -
                                                        1 -
                                                        index]
                                                .message),
                                          )
                                        ],
                                      )
                                    ]))));
                      })))
        ]);
  }
}
