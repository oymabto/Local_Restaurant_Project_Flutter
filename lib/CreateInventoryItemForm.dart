/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// This CreateInventoryItemForm class is a custom widget that shows a form to create a new inventory item.
/// Users can enter the item's name, image URL, and quantity.
/// When the 'Create' button is pressed, the form's information gets saved to a database.
class CreateInventoryItemForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final quantityController = TextEditingController();

  CreateInventoryItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Inventory Item"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {

                  /// This checks if all the fields are okay.
                  if (_formKey.currentState!.validate()) {

                    /// This sends the information to the database.
                    FirebaseFirestore.instance.collection('inventory').add({
                      'name': nameController.text,
                      'imageUrl': imageUrlController.text,
                      'quantity': int.parse(quantityController.text),
                    });

                    /// This takes the user back to the previous screen.
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
