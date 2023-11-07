import 'package:expense_tracker/models/bills.dart';
import 'package:expense_tracker/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BillController extends GetxController {
  var theList = [].obs;
  var theListFromJson = [].obs;
  var total = 0.obs;

  Future<void> fetchData() async {
    var response = await FetchData.getData("bill") as List;
    var dummy = [];
    total.value = 0;
    // ignore: invalid_use_of_protected_member
    for (var item in response) {
      total.value += item["amount"] as int;
      item = Map.from(item);
      item["color"] = Color(item["color"]);

      dummy.add(item);
    }
    theList.value = dummy;
  }

  Future<void> insertData(bill) async {
    FetchData.insertBill(bill);
    fetchData();
  }

  fromJson() async {
    var dummy = [];
    // ignore: invalid_use_of_protected_member
    for (var item in theList.value) {
      dummy.add(Bill.fromJson(item));
    }
    theListFromJson.value = dummy;
  }

  delete(query) async {
    FetchData.deleteData("bill", query);
    fetchData();
  }
}
