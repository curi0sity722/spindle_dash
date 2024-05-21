import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';

class MultiLineGraph extends StatefulWidget {
  const MultiLineGraph({super.key});

  @override
  State<MultiLineGraph> createState() => MultiLineGraphState();
}

class Data {
  Data(this.freq, this.y1, this.y2);
  final double freq;
  final double y1;
  final double y2;
}

class MultiLineGraphState extends State<MultiLineGraph> {
  List<Data> plotData = [];

  @override
  void initState() {
    super.initState();
    plotData = getPlotData();
  }

  List<Data> getPlotData() {
    List<Data> data = [];
    Random random = Random();

    for (int i = 0; i < 100; i++) {
      double freq = (i / 100) * 1000;
      double y1 = random.nextDouble() * 100;
      double y2 = random.nextDouble() * 100;
      data.add(Data(freq, y1, y2));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SfCartesianChart(
                // title: const ChartTitle(text: 'FFT Data plot'),
                legend: Legend(isVisible: true),
                primaryXAxis: NumericAxis(
                  labelFormat: '{value}Hz',
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  title: AxisTitle(text: "Frequency in Hz"),
                ),
                primaryYAxis: NumericAxis(
                  name: "FFT Data count",
                  title: AxisTitle(text: "FFT"),
                  axisLine: AxisLine(width: 1),
                  majorTickLines: MajorTickLines(color: Colors.transparent),
                ),
                series: <LineSeries>[
                  LineSeries<Data, double>(
                    dataSource: plotData,
                    xValueMapper: (Data vals, _) => vals.freq,
                    yValueMapper: (Data vals, _) => vals.y1,
                    name: "History Data",
                    // markerSettings: const MarkerSettings(isVisible: true)
                  ),
                  LineSeries<Data, double>(
                    dataSource: plotData,
                    xValueMapper: (Data vals, _) => vals.freq,
                    yValueMapper: (Data vals, _) => vals.y2,
                    name: "Today Data",
                    // markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
