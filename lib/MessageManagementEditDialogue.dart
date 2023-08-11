/// Devin Oxman

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'main.dart';

/// This class generates the dialogue to edit current messages or create new ones
/// It must be passed an isNew boolean to determine whether it is generating a new message or editing a current one
/// It should be passed a reference to the current object if isNew is set to false
class EditMessageDialogue extends StatelessWidget {
  final DocumentSnapshot? messageData;
  final BuildContext parentContext;
  final bool isNew;
  String id = '';
  String date= '';
  bool isSeen = false;
  String message= '';

  /// This function finds the number of documents in the messages and returns a future<int> of the id for the next document to be inserted
  /// We don't want the id's to be random, but rather be sequential
  Future<String> generateNewMessageId() async {

    /// Fetches the documents in the 'managersUpdates' collection
    final snapshot = await FirebaseFirestore.instance.collection('managersUpdates').get();

    /// Returns the count of the documents in the collection + 1, as a string
    return (snapshot.docs.length+1).toString();
  }


  EditMessageDialogue({
    Key? key,
    this.messageData,
    required this.parentContext,
    required this.isNew,
  }) : super(key: key);

  /// loads data from the referenced database object if this is an update to a message
  Future<void> _editMessage() async {
    if(!isNew) {

      /// As in the editDrivers class, it either grabs the data from the database document or sets it to an empty string, or in the case of isSeen, false
      date = (messageData?.data() as Map<String,
          dynamic>?)?['date'] ?? '';
      isSeen = (messageData?.data() as Map<String,
          dynamic>?)?['isSeen'] ?? false;
      message = (messageData?.data() as Map<String,
          dynamic>?)?['message'] ?? '';
    }

    await showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isNew ? 'Create Message' : 'Edit Message'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  message = value;
                },
                controller: TextEditingController(text: message),
                decoration: InputDecoration(
                  labelText: 'Message for drivers:',
                ),
              ),
            ],
          ),
          /// Buttons to save or cancel the dialogue
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (isNew) {

                  /// Calls the generateNewMessageId function to get the new id for the document to be created
                  id = await generateNewMessageId();
                  DateTime now = DateTime.now();
                  String formattedDate = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
                  String formattedTime = "${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}";
                  date = formattedDate + " " + formattedTime;

                  /// Creates a new document using set not add so we can specify the document id
                  /// Cobbled together from
                  /// https://saveyourtime.medium.com/firebase-cloud-firestore-add-set-update-delete-get-data-6da566513b1b
                  FirebaseFirestore.instance.collection('managersUpdates').doc(id).set({
                    'date': date,
                    'isSeen': false,
                    'message': message
                  });
                }  else {

                  /// Normal database update message document
                  await messageData!.reference.update({
                    'date': date,
                    'isSeen': false,
                    'message': message
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    /// Generates the initial button to show the dialogue
    /// Depending on the value of the isNew boolean either creates an add or edit button
    if(isNew) {
      return IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _editMessage(),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _editMessage(),
      );
    }
  }
}