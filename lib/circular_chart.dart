import 'package:expense_tracker/assets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CircularChart extends StatelessWidget {
  String title;
  var controller;
  CircularChart(this.title, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    // final List chartData = controller.theListFromJson;
    return Scaffold(
      body: Center(
        child: Container(
          color: backgroundColor,
          child: Obx(() {
            return SfCircularChart(
              title: ChartTitle(
                text: title,
                textStyle: GoogleFonts.akayaKanadaka(
                    fontStyle: FontStyle.italic,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
              ),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        NumberFormat("#,###")
                            .format(int.parse("${controller.total}")),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                )
              ],
              series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<dynamic, String>(
                    innerRadius: "96%",
                    // radius: "50%",
                    name: "Doughnut",
                    dataSource: controller.theListFromJson,
                    pointColorMapper: (var data, _) => data.color,
                    xValueMapper: (var data, _) => data.name,
                    yValueMapper: (var data, _) => data.amount)
              ],
            );
          }),
        ),
      ),
    );
  }
}
