import 'package:expense_tracker/assets/Colors.dart';
import 'package:expense_tracker/controllers/account_controller.dart';
import 'package:expense_tracker/controllers/bill_controller.dart';
import 'package:expense_tracker/controllers/budget_controller.dart';
import 'package:expense_tracker/my_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Overview extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var size;
  Overview({this.size, super.key});

  final accountController = Get.find<AccountController>();
  final billController = Get.find<BillController>();
  final budgetController = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Accounts",
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat("#,###")
                          .format(int.parse("${accountController.total}")),
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                      child: MyCard(
                        controller: accountController,
                        size: size,
                        max: 3,
                      ),
                    ),
                    Visibility(
                      visible: accountController.theList.length > 3,
                      child: TextButton(
                        onPressed: () {
                          DefaultTabController.of(context).animateTo(1);
                        },
                        child: const Text("See More..."),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bills",
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat("#,###")
                          .format(int.parse("${billController.total}")),
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                      child: MyCard(
                        controller: billController,
                        size: size,
                        max: 3,
                      ),
                    ),
                    Visibility(
                      visible: billController.theList.length >= 3,
                      child: TextButton(
                        onPressed: () {
                          DefaultTabController.of(context).animateTo(2);
                        },
                        child: const Text("See More..."),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budgets",
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat("#,###")
                          .format(int.parse("${budgetController.total}")),
                      style: GoogleFonts.abel(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                      child: MyCard(
                        controller: budgetController,
                        size: size,
                        max: 3,
                      ),
                    ),
                    Visibility(
                      visible: budgetController.theList.length > 3,
                      child: TextButton(
                        onPressed: () {
                          DefaultTabController.of(context).animateTo(3);
                        },
                        child: const Text("See More..."),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
