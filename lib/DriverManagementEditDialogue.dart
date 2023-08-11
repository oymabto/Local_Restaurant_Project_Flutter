/// Devin Oxman

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'main.dart';

/// This class renders the dialogue to edit a current driver or add a new driver
class EditDriverDialogue extends StatelessWidget {
  final DocumentSnapshot? driverData;
  final BuildContext parentContext;
  final bool isNew;
  String id = '';
  String name = '';
  String family = '';
  String email = '';
  String username= '';
  String password= '';
  String imageUrl= '';

  /// This function generates alpha-numeric ids and before returning one queries the database to make sure it is not already in use
  /// It uses the below _generateRandomString function to generate the sequence of characters
  Future<String> generateUniqueID() async {
    bool idExists = true;
    String uniqueID = "";
    while (idExists) {
      uniqueID = _generateRandomString(8);
      final snapshot =
      await FirebaseFirestore.instance.collection('drivers').doc(uniqueID).get();
      if (!snapshot.exists) {
        idExists = false;
      }
    }
    return uniqueID;
  }

  /// This function generates a random alpha-numeric string to be used in the generateUniqueId function
  /// The length arguement will set the length of the string
  String _generateRandomString(int length) {
    const _allowedChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final _random = Random();
    return List.generate(length, (index) {
      return _allowedChars[_random.nextInt(_allowedChars.length)];
    }).join();
  }
  /// Constructor which has a boolean to either pre-populate the dialogue with the current user or generate an empty one to add a new user
  EditDriverDialogue({
    Key? key,
    this.driverData,
    required this.parentContext,
    required this.isNew,
  }) : super(key: key);
  /// This function renders the dialogue, it either pre-populates the dialogue based on the document snapshot which is also passed to this class or generates an empty dialogue
  Future<void> _editDriver() async {
    if(!isNew) {
      /// Each of the below fields is either pulled from the database document, or if missing is assigned as an empty field
      /// This guards against any unpopulated fields in the database
      name = (driverData?.data() as Map<String, dynamic>?)?['name'] ??
          '';
      family = (driverData?.data() as Map<String,
          dynamic>?)?['family'] ?? '';
      email = (driverData?.data() as Map<String, dynamic>?)?['email'] ??
          '';
      username = (driverData?.data() as Map<String,
          dynamic>?)?['username'] ?? '';
      password = (driverData?.data() as Map<String,
          dynamic>?)?['password'] ?? '';
      imageUrl = (driverData?.data() as Map<String,
          dynamic>?)?['imageUrl'] ?? '';
    }

    await showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isNew ? 'Create Driver' : 'Edit Driver'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController(text: name),
                decoration: InputDecoration(
                  labelText: 'Name:',
                ),
              ),
              TextField(
                onChanged: (value) {
                  family = value;
                },
                controller: TextEditingController(text: family),
                decoration: InputDecoration(
                  labelText: 'Family:',
                ),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                controller: TextEditingController(text: email),
                decoration: InputDecoration(
                  labelText: 'Email:',
                ),
              ),
              TextField(
                onChanged: (value) {
                  username = value;
                },
                controller: TextEditingController(text: username),
                decoration: InputDecoration(
                  labelText: 'Username:',
                ),
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                controller: TextEditingController(text: password),
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextField(
                onChanged: (value) {
                  imageUrl = value;
                },
                controller: TextEditingController(text: imageUrl),
                decoration: InputDecoration(
                  labelText: 'Image Url:',
                ),
              ),
            ],
          ),
          /// Buttons to save or cancel the dialogue
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                /// If this is a new user, an id will be generated and it will be added to the collection
                if (isNew) {
                  id = await generateUniqueID();
                  FirebaseFirestore.instance.collection('drivers').add({
                    'id': id,
                    'name': name,
                    'family': family,
                    'email': email,
                    'username': username,
                    'password': password,
                    'imageUrl': imageUrl,
                    'availability': false
                  });
                } else {
                  /// If this is an edit of an existing user the user document will be updated instead
                  await driverData!.reference.update({
                    'name': name,
                    'family': family,
                    'email': email,
                    'username': username,
                    'password': password,
                    'imageUrl': imageUrl
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
    /// If this widget is generated with the isNew boolean set to true it will generate an add button
    /// Otherwise it will generate an edit button
    if(isNew) {
      return IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _editDriver(),
      );
    } else {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _editDriver(),
      );
    }
  }
}