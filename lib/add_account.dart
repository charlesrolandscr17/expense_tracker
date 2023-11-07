import 'dart:math';

import 'package:expense_tracker/assets/Colors.dart';
import 'package:expense_tracker/home.dart';
import 'package:expense_tracker/models/account.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddAccount extends StatelessWidget {
  AddAccount({super.key});
  String name = "";
  int amount = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: backgroundColor,
        title: const Text(
          "Add Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (text) {
                name = text;
              },
              decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.white)),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please give a name';
                }
                return null;
              },
            ),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (text) {
                amount = int.tryParse(text)!;
              },
              decoration: const InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(color: Colors.white)),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please give an amount';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    FetchData.insertAccount(
                      Account(
                        amount: amount,
                        name: name,
                        id: 1,
                        color: Color.fromARGB(
                          255,
                          Random().nextInt(255),
                          Random().nextInt(255),
                          Random().nextInt(255),
                        ),
                      ),
                    );
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data Added...')),
                    );

                    Get.offAll(() => MyHomePage());
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
