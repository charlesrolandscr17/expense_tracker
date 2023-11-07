// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:expense_tracker/individual_card.dart';
import 'package:expense_tracker/no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyCard extends StatefulWidget {
  var controller;
  int max;
  Size size;
  MyCard(
      {required this.max,
      required this.controller,
      required this.size,
      super.key});

  @override
  // ignore: no_logic_in_create_state
  State<MyCard> createState() => _MyCardState(controller, max, size);
}

class _MyCardState extends State<MyCard> {
  var controller;
  var data;
  var max;
  var size;
  _MyCardState(
    this.controller,
    this.max,
    this.size,
  );

  @override
  void initState() {
    controller.fetchData();
    controller.fromJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.theList.isNotEmpty) {
          if (widget.max != 0) {
            // ignore: unrelated_type_equality_checks
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.theList.length >= max
                    ? 3
                    : controller.theList.length,
                itemBuilder: (context, index) {
                  data = controller.theList[index];
                  return IndividualCard(
                    controller: controller,
                    del: false,
                    size: size,
                    color: data["color"],
                    amount: data['amount'],
                    id: data['id'],
                    name: data['name'],
                  );
                });
          }
          return ListView.builder(
              itemCount: controller.theList.length,
              itemBuilder: (context, index) {
                data = controller.theList[index];
                return IndividualCard(
                  controller: controller,
                  del: true,
                  size: widget.size,
                  color: data["color"],
                  amount: data['amount'],
                  id: data['id'],
                  name: data['name'],
                );
              });
        }
        return const NoData();
      },
    );
  }
}
