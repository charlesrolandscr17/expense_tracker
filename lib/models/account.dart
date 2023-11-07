// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  String name;
  int id;
  int amount;
  Color? color = Colors.blue;

  Account({
    this.color,
    required this.name,
    required this.id,
    required this.amount,
  });

  factory Account.fromJson(Map<dynamic, dynamic> json) => Account(
        color: json["color"],
        name: json["name"],
        id: json["id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "color": color!.value,
      };
}
