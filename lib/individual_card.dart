import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'assets/Colors.dart';

// ignore: must_be_immutable
class IndividualCard extends StatelessWidget {
  Color color;
  String name;
  int id;
  int amount;
  bool del;
  var controller;

  IndividualCard({
    super.key,
    required this.size,
    required this.del,
    required this.name,
    required this.id,
    required this.amount,
    required this.color,
    required this.controller,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        margin: const EdgeInsets.only(left: 10),
        width: size.width,
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "$id",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$amount",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  del
                      ? IconButton(
                          onPressed: () {
                            controller.delete(id);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.trash,
                            size: 15,
                            color: Colors.white,
                          ))
                      : const FaIcon(
                          FontAwesomeIcons.greaterThan,
                          size: 13,
                          color: Colors.white,
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
