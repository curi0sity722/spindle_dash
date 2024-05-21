import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});

  @override
  State<BarGraph> createState() => BarGraphState();
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

class BarGraphState extends State<BarGraph> {
  List<ChartData> plotData = [];

  @override
  void initState() {
    plotData = getPlotData();
    super.initState();
  }

  List<ChartData> getPlotData() {
    List<ChartData> data = [];
    Random random = Random();

    for (int i = 0; i < 100; i++) {
      double x = (i / 100) * 1000;
      double y = random.nextDouble() * 10;
      data.add(ChartData(x, y));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: NumericAxis(
              labelFormat: '{value}Hz',
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              title: AxisTitle(text: "Frequency in Hz"),
            ),
            primaryYAxis: NumericAxis(
              // labelFormat: '{value}Hz',
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              title: AxisTitle(text: "Vibration Velocity (rms)"),
            ),
            series: <CartesianSeries<ChartData, double>>[
              // Renders column chart
              ColumnSeries<ChartData, double>(
                  dataSource: plotData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
            ],
          ),
        ),
      ),
    );
  }
}
