import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

Bill billFromJson(String str) => Bill.fromJson(json.decode(str));

String billToJson(Bill data) => json.encode(data.toJson());

class Bill {
  String name;
  int id;
  int amount;
  int account;
  Color? color = Colors.blue;

  Bill({
    this.color,
    required this.name,
    required this.id,
    required this.amount,
    required this.account,
  });

  factory Bill.fromJson(Map<dynamic, dynamic> json) => Bill(
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
