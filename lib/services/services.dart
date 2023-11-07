import 'package:expense_tracker/models/account.dart';
import 'package:expense_tracker/models/bills.dart';
import 'package:expense_tracker/models/budgets.dart';
import 'package:sqflite/sqflite.dart';

class FetchData {
  static Database? database;
  static var path;
  static Future<void> deleteMyDatabase(path) async {
    // Close any open connections to the database
    await (await openDatabase(FetchData.path)).close();

    // Delete the database file
    await deleteDatabase(FetchData.path);

    print("Database deleted successfully.");
  }

  static getData(String table) async {
    return await FetchData.database!.rawQuery('SELECT * FROM $table');
  }

  static getIndividualData(String table, value, key) async {
    return await FetchData.database!
        .rawQuery('SELECT * FROM $table WHERE $key = $value');
  }

  static deleteData(table, query) async {
    return await FetchData.database!
        .rawDelete('DELETE FROM $table WHERE id = ?', ['$query']);
  }

  // Define a function that inserts dogs into the database
  static insertAccount(Account acc) async {
    // Get a reference to the database.

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await FetchData.database!.insert(
      'account',
      acc.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  static insertBill(Bill bill) async {
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await FetchData.database!.insert(
      'bill',
      bill.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  static void insertBudget(Budget budget) async {
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await FetchData.database!.insert(
      'budget',
      budget.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
