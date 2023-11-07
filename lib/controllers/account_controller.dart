import 'package:expense_tracker/models/account.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AccountController extends GetxController {
  var theList = [].obs;
  var theListFromJson = [].obs;
  var total = 0.obs;
  var accounts = [];
  final value = "account".obs;

  Future<void> fetchData() async {
    var response = await FetchData.getData("account") as List;
    var dummy = [];
    total.value = 0;
    // ignore: invalid_use_of_protected_member
    for (var item in response) {
      total.value += item["amount"] as int;
      accounts.add(item["id"]);
      item = Map.from(item);
      item["color"] = Color(item["color"]);

      dummy.add(item);
    }
    theList.value = dummy;
  }

  void changeValue(text) {
    value.value = text;
    update();
  }

  Future<void> insertData(account) async {
    FetchData.insertAccount(account);
    fetchData();
  }

  fromJson() async {
    var dummy = [];
    // ignore: invalid_use_of_protected_member
    for (var item in theList.value) {
      dummy.add(Account.fromJson(item));
    }
    theListFromJson.value = dummy;
  }

  delete(query) async {
    FetchData.deleteData("account", query);
    fetchData();
  }
}
