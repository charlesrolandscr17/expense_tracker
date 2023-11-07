import 'package:expense_tracker/assets/Colors.dart';
import 'package:expense_tracker/linear_gauge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var controller;
  DetailPage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: backgroundColor,
        title: const Center(
          child: Text(
            "Checking",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.5,
            child: const LinearGauge(),
          ),
        ],
      ),
    );
  }
}
