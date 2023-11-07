import 'package:expense_tracker/controllers/account_controller.dart';
import 'package:expense_tracker/controllers/bill_controller.dart';
import 'package:expense_tracker/controllers/budget_controller.dart';
import 'package:expense_tracker/controllers/database.dart';
import 'package:expense_tracker/controllers/page_controller.dart';
import 'package:expense_tracker/home.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AccountController());
        Get.put(BillController());
        Get.put(BudgetController());
        Get.put(MyPageController());
      }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.mondaTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
