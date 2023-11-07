import 'dart:math';

import 'package:expense_tracker/assets/Colors.dart';
import 'package:expense_tracker/controllers/account_controller.dart';
import 'package:expense_tracker/home.dart';
import 'package:expense_tracker/models/budgets.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddBudget extends StatelessWidget {
  AddBudget({super.key});
  String name = "";
  int account = 0;
  int amount = 0;
  AccountController controller = Get.find();
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
          "Add Budget",
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
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (text) {
                account = int.tryParse(text)!;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: "Account",
                  labelStyle: TextStyle(color: Colors.white)),
              // The validator receives the text that the user has entered.
              validator: (value) {
                // print(FetchData.getIndividualData("account", value, ""));
                if (value == null || value.isEmpty) {
                  return 'Please give an amount';
                } else if (!controller.accounts.contains(account)) {
                  return 'Please give select Valid account';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(backgroundColor)),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    FetchData.insertBudget(
                      Budget(
                        amount: amount,
                        name: name,
                        id: 1,
                        account: account,
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

                    Get.offAll(MyHomePage());
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
