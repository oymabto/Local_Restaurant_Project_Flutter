/// Devin Oxman

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'MessageManagementEditDialogue.dart';
import 'MessageData.dart';
import 'main.dart';


/// This card displays the information for the management update messages
/// It will be passed a MessageData object for display and a document snapshot reference for updating and deletion
class MessageManagementCard extends StatelessWidget {
  /// Instantiate a snapshot to connect to the firebase collection
  final DocumentSnapshot messageData;
  final MessageData message;

  const MessageManagementCard({
    Key? key,
    required this.message, required this.messageData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${message.date}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text("${message.message}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              /// Buttons to edit and delete the current message
              children: [
                EditMessageDialogue(messageData: messageData, isNew: false, parentContext: context),

                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    messageData.reference.delete();
                  },
                ),              ],
            ),
          ],
        ),
      ),
    );
  }
}