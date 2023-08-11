/// Done by Alireza

import 'package:flutter/cupertino.dart';

import 'OrderCard.dart';

class OrdersListView extends StatelessWidget {
  final List<dynamic> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      /// The number of items in the list is equal to the number of documents retrieved from Firestore.
      itemCount: orders.length,

      /// itemBuilder builds each individual item in the list.
      /// It passes the data of each document to the OrderCard widget.
      itemBuilder: (context, index) {
        return OrderCard(orderData: orders[index]);
      },
    );
  }
}