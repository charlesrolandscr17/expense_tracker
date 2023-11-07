import 'package:expense_tracker/add_account.dart';
import 'package:expense_tracker/add_bill.dart';
import 'package:expense_tracker/add_budget.dart';
import 'package:expense_tracker/chart_page.dart';
import 'package:expense_tracker/controllers/account_controller.dart';
import 'package:expense_tracker/controllers/bill_controller.dart';
import 'package:expense_tracker/controllers/budget_controller.dart';
import 'package:expense_tracker/controllers/database.dart';
import 'package:expense_tracker/controllers/page_controller.dart';
import 'package:expense_tracker/overview.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'assets/Colors.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseController db = Get.put(DatabaseController());

  final BudgetController budget = Get.put(BudgetController());

  final BillController bill = Get.put(BillController());

  final AccountController acc = Get.put(AccountController());

  final MyPageController page = Get.put(MyPageController());

  var id = 0;

  @override
  void initState() {
    runDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<AccountController>(
      builder: (_) {
        return DefaultTabController(
          initialIndex: page.page,
          length: 5,
          child: Scaffold(
            floatingActionButton: ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Add",
                    backgroundColor: Colors.white,
                    titleStyle: const TextStyle(color: Colors.black),
                    textConfirm: "Add",
                    textCancel: "Cancel",
                    cancelTextColor: Colors.blue,
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      print(acc.value.value);
                      if (acc.value.value == "account") {
                        Get.to(() => AddAccount());
                      } else if (acc.value.value == "bill") {
                        acc.value.value = "account";
                        Get.to(() => AddBill());
                      } else if (acc.value.value == "budget") {
                        acc.value.value = "account";
                        Get.to(() => AddBudget());
                      }
                    },
                    buttonColor: Colors.blue,
                    barrierDismissible: true,
                    radius: 20,
                    content: Obx(() => DropdownButton(
                          onChanged: (text) {
                            acc.changeValue(text);
                          },
                          value: acc.value.value,
                          items: const [
                            DropdownMenuItem(
                              value: "account",
                              child: Text("Account"),
                            ),
                            DropdownMenuItem(
                              value: "bill",
                              child: Text("Bill"),
                            ),
                            DropdownMenuItem(
                              value: "budget",
                              child: Text("Budget"),
                            ),
                          ],
                        )),
                  );
                },
                child: const FaIcon(FontAwesomeIcons.add)),
            backgroundColor: backgroundColor,
            appBar: AppBar(
              foregroundColor: Colors.red,
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              title: const TabBar(
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                    child: Icon(
                      Icons.pie_chart,
                    ),
                  ),
                  Tab(
                    child: FaIcon(
                      FontAwesomeIcons.dollarSign,
                    ),
                  ),
                  Tab(
                    child: FaIcon(
                      FontAwesomeIcons.moneyBill,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.table_chart,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.settings,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Overview(
                  size: size,
                ),
                Center(
                  child: ChartPage(
                    "Accounts",
                    controller: acc,
                  ),
                ),
                Center(
                  child: ChartPage(
                    "Bills",
                    controller: bill,
                  ),
                ),
                Center(
                  child: ChartPage(
                    "Budgets",
                    controller: budget,
                  ),
                ),
                Center(
                    child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          FetchData.deleteMyDatabase(db.path)
                              .catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error deleting database')));
                          });
                          Get.offAll(() => MyHomePage());
                        },
                        child: const Text("Delete")),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

void runDB() async {
  DatabaseController databaseController = Get.put(DatabaseController());
  var databasePath = await getDatabasesPath();
  databaseController.path = join(databasePath, 'expense_  tracker_db.db');

  databaseController.database = await openDatabase(
    databaseController.path,
    version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE IF NOT EXISTS account (id INTEGER PRIMARY KEY, name TEXT, amount INTEGER, color INTEGER)',
      );
      await db.execute(
        'CREATE TABLE IF NOT EXISTS bill (id INTEGER PRIMARY KEY,amount DECIMAL NOT NULL,name TEXT NOT NULL, color INTEGER, accountId INTEGER NOT NULL,FOREIGN KEY (accountId) REFERENCES Account(id))',
      );
      await db.execute(
        'CREATE TABLE IF NOT EXISTS budget (id INTEGER PRIMARY KEY,amount DECIMAL NOT NULL,name TEXT NOT NULL, color INTEGER, accountId INTEGER NOT NULL,FOREIGN KEY (accountId) REFERENCES Account(id))',
      );
    },
  );

  FetchData.database = databaseController.database;
  FetchData.path = databaseController.path;
}
