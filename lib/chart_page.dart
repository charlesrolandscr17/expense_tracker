import 'package:expense_tracker/circular_chart.dart';
import 'package:expense_tracker/my_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChartPage extends StatelessWidget {
  String title;
  var controller;
  ChartPage(this.title, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.5, child: CircularChart(title, controller: controller,)),
          const Divider(
            height: 8,
            color: Colors.black,
          ),
          Expanded(
            child: MyCard(
              controller: controller,
              size: size,
              max: 0,
            ),
          )
        ],
      ),
    );
  }
}
