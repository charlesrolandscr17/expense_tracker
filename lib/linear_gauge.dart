import 'package:flutter/material.dart';

class LinearGauge extends StatelessWidget {
  const LinearGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // child: SfCartesianChart(
          //   backgroundColor: backgroundColor,
          //   series: <ChartSeries>[
          //     StepLineSeries<ChartData, int>(
          //       color: Color.fromARGB(255, 4, 241, 75),
          //       animationDelay: 2.0,
          //       dataSource: chartData,
          //       xValueMapper: (ChartData data, _) => data.x,
          //       xAxisName: "Number",
          //       yValueMapper: (ChartData data, _) => data.y,
          //       yAxisName: "Month",
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
