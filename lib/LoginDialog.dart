/// Done by Alireza

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// LoginDialog extends StatefulWidget because it has mutable state.
class LoginDialog extends StatefulWidget {

  /// onLoginSuccess named parameter which is a function that accepts two strings.
  /// This function will be called when the login is successful.
  final Function(String, String, String, String) onLoginSuccess;

  /// LoginDialog class constructor that can be used to create compile-time constant instances of this class.
  /// This means that if you create two instances of LoginDialog with the exact same parameters
  /// , they will actually be the same instance in memory.
  /// This can have performance benefits.
  /// Key? key, is a named, optional parameter key of type Key.
  /// The key is a unique identifier that can be associated with a widget.
  /// Keys are mainly used for efficiently updating or keeping track of the state in widgets
  /// like lists where the order and number of children widgets might change dynamically.
  /// this.onLoginSuccess is a named parameter which is marked as required, meaning that
  /// it must be non-null and must be passed when creating an instance of LoginDialog.
  /// The this.onLoginSuccess syntax automatically assigns the value passed to onLoginSuccess to the instance variable onLoginSuccess of the class.
  /// This parameter expects a function that takes two String parameters.
  /// This function will be called when a login is successful.
  /// : super(key: key); calls the parent class's constructor (super) with the key parameter passed into this constructor.
  /// The parent class is StatefulWidget.
  /// The StatefulWidget takes an optional key as a parameter, and by passing it to the parent class
  /// , you're allowing the LoginDialog to utilize this functionality from StatefulWidget.
  const LoginDialog({
    Key? key,
    required this.onLoginSuccess,
  }) : super(key: key);

  /// @override is indicating that you're overriding the 'createState' method from the 'StatefulWidget' class.
  /// createState is a fundamental part of the contract when creating a StatefulWidget.
  /// StatefulWidgets are designed to have mutable state, and this method tells Flutter what object will hold that state.
  /// The returned State object is then used by Flutter to build and manage the mutable state of this widget.
  /// The => syntax is a shorthand for { return _LoginDialogState(); }.
  /// _LoginDialogState holds the state for LoginDialog.
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

/// class _LoginDialogState means we're creating a blueprint for an object, which we're naming _LoginDialogState.
/// This is like creating a recipe; it's a set of instructions for making an object in our code.
/// extends State<LoginDialog> tells Dart that _LoginDialogState is going to be a special kind of class which builds on top of another class called State.
/// The <LoginDialog> part specifies that this state is specifically for the LoginDialog widget.
/// We need the class _LoginDialogState to keep track of things that can change inside our widget, like what the user types, or if there's an error message to show.
/// The _username, _password, _usernameError, and _passwordError are the actual things we want to keep track of.
/// They're like containers where we store the values the user types and any error messages that might come up.
class _LoginDialogState extends State<LoginDialog> {
  String _username = '';
  String _password = '';
  String _usernameError = '';
  String _passwordError = '';
  String _loginFailureMessage = '';

  /// It creates a FirebaseFirestore instance which is used to communicate with the Firestore database.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// It is asynchronous and doesn't return anything.
  /// This method is called when the user tries to login.
  /// Inside the _handleLogin method, it calls setState to update the state of the widget.
  /// This block sets _usernameError and _passwordError depending on the validity of the _username and _password fields.
  void _handleLogin() async {
    setState(() {
      _usernameError = _username.isEmpty
          ? "Username can't be empty"
          : _username.length < 6
          ? "Username should be at least 8 characters"
          : '';

      _passwordError = _password.isEmpty
          ? "Password can't be empty"
          : _password.length < 6
          ? "Password should be at least 8 characters"
          : '';

      _loginFailureMessage = '';
    });

    /// It creates an instance of Firestore, and fetches documents from the collections 'managers' and 'drivers' where the username matches the entered username.
    /// All the prints are for checking and debugging
    if (_usernameError.isEmpty && _passwordError.isEmpty) {
      print("Username entered: $_username");
      print("Password entered: $_password");
      final firestore = FirebaseFirestore.instance;
      final managers = await firestore.collection('managers').where('username', isEqualTo: _username).get();
      final drivers = await firestore.collection('drivers').where('username', isEqualTo: _username).get();
      print("Managers: ${managers.docs}");
      print("Drivers: ${drivers.docs}");

      /// It check if the user is found in either the managers or drivers collections, and if found, it calls onLoginSuccess.
      /// If not found in either, it prints "User not found" to the console.
      if (managers.docs.isNotEmpty) {
        print("Manager found");
        final managerDoc = managers.docs.first;
        final String name = managerDoc ['name'];
        final String family = managerDoc ['family'];
        final String id = managerDoc['id'];
        widget.onLoginSuccess(name, family, 'manager', id);
      } else if (drivers.docs.isNotEmpty) {
        print("Driver found");
        final driverDoc = drivers.docs.first;
        final String name = driverDoc ['name'];
        final String family = driverDoc ['family'];
        final String id = driverDoc['id'];
        widget.onLoginSuccess(name, family, 'driver', id);
      } else {
        print("User not found");
        _loginFailureMessage = 'Login failed, user not found. Please try again.';
        _username = '';
        _password = '';
        print(_loginFailureMessage);
      }
    }
  }

  /// We create this  method _addDocument to add a document to the Firestore database in the collection called 'testCollection'
  /// it is for checking if there is a successfull connection to the database
  void _addDocument() async {
    try {
      await _firestore.collection('testCollection').add({
        'name': 'Paul Stuart',
        'age': 30,
        'email': 'paul.stuart@bob.cs',
      });
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => setState(() => _username = value),
              decoration: InputDecoration(
                labelText: "Enter username",
                prefixIcon: const Icon(Icons.account_circle),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _username = ''),
                ),
              ),
            ),
            if (_usernameError.isNotEmpty)
              Text(_usernameError,
                  style: const TextStyle(color: Colors.red, fontSize: 12)),
            TextField(
              onChanged: (value) => setState(() => _password = value),
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _password = ''),
                ),
              ),
            ),
            if (_passwordError.isNotEmpty)
              Text(_passwordError,
                  style: const TextStyle(color: Colors.red, fontSize: 12)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: const Text("Login"),
                ),
              ],
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _addDocument,
            //   child: const Text("Write to Firestore database"),
            // ),
          ],
        ),
      ),
    );
  }
}
