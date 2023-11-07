import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

Budget BudgetFromJson(String str) => Budget.fromJson(json.decode(str));

String BudgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
  String name;
  int id;
  int amount;
  int account;
  Color? color = Colors.blue;

  Budget({
    this.color,
    required this.name,
    required this.id,
    required this.amount,
    required this.account,
  });

  factory Budget.fromJson(Map<dynamic, dynamic> json) => Budget(
        color: json["color"],
        name: json["name"],
        id: json["id"],
        amount: json["amount"],
        account: json["account"] ?? Random().nextInt(566),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "accountId": account,
        "color": color!.value,
      };
}
