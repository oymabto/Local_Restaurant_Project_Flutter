/// Devin Oxman

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MessageManagementCard.dart';
import 'MessageManagementEditDialogue.dart';
import 'MessageData.dart';
import 'main.dart';

/// This widget generates the list of manager update messages that will be sent to drivers
class DriverManagementListMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('managersUpdates').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              /// Convert list of database documents to a list of MessageData objects
              List<MessageData> listOfMessages = snapshot.data!.docs.map((doc) => MessageData(
                  date: doc['date'],
                  isSeen: doc['isSeen'],
                  message: doc['message']
              )).toList();

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: listOfMessages.length,
                  itemBuilder: (context, index) {
                    /// Calls a card for each message to dispay the content
                    /// Presents them in reverse chronological order so the most recent message is at the top of the list
                    /// Passes the MessageData object to display and a snapshot reference for updating and deletion
                    return MessageManagementCard(message: listOfMessages[listOfMessages.length - 1 - index], messageData: snapshot.data!.docs[listOfMessages.length - 1 - index]);
                  });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),

          /// Calls the EditMessageDialogue class to generate a button to add a new message
          child: EditMessageDialogue(isNew: true, parentContext: context),
        ),
      ],
    );
  }
}