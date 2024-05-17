import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../provider/user_provider.dart';

class EnergyMonitoring extends StatefulWidget {
  const EnergyMonitoring({super.key});

  @override
  State<EnergyMonitoring> createState() => _EnergyMonitoringState();
}

class _EnergyMonitoringState extends State<EnergyMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularGraph(),
            LineGraph(),
          ],
        );
  }
}

class TimeSeriesData {
  TimeSeriesData(this.time, this.value1, this.value2, this.value3);

  final DateTime time;
  final double value1;
  final double value2;
  final double value3;
}

class LineGraph extends StatefulWidget {
  const LineGraph({super.key});

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  @override
  Widget build(BuildContext context) {
    final List<TimeSeriesData> chartData = [
      TimeSeriesData(DateTime(2023, 1, 1), 30, 40, 50),
      TimeSeriesData(DateTime(2023, 1, 2), 35, 45, 55),
      TimeSeriesData(DateTime(2023, 1, 3), 40, 50, 60),
      TimeSeriesData(DateTime(2023, 1, 4), 45, 55, 65),
      TimeSeriesData(DateTime(2023, 1, 5), 50, 60, 70),
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.25,
      height: height * 0.4,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<TimeSeriesData, DateTime>(
            //name: 'Temperature',
            name: '',
            dataSource: chartData,
            xValueMapper: (TimeSeriesData data, _) => data.time,
            yValueMapper: (TimeSeriesData data, _) => data.value1,
            markerSettings: MarkerSettings(isVisible: true),
          ),
          
        ],
      ),
    );
  }
}

class CircularGraph extends StatefulWidget {
  const CircularGraph({super.key});

  @override
  State<CircularGraph> createState() => _CircularGraphState();
}

class _CircularGraphState extends State<CircularGraph> {
  double _cirvalue1 = 0.7; // Your initial value
  double _cirvalue2 = 0.3;
  double _cirvalue3 = 0.5;

  @override
  void initState() {
    super.initState();
    // Start a timer to update the values every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final random = Random();
        _cirvalue1 = 0.69 + (random.nextDouble() * (0.72 - 0.69));
        _cirvalue2 = 0.29 + (random.nextDouble() * (0.32 - 0.29));
        _cirvalue3 = 0.49 + (random.nextDouble() * (0.52 - 0.49));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CircularPercentIndicator(
      radius: (12 / 100) *
          min(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
      lineWidth: 15.0,
      percent: Provider.of<InitialDurationProvider>(context, listen: false)
              .handleStartStop
          ? _cirvalue1
          : 0.7,
      center: Text(
        "${(100 * (Provider.of<InitialDurationProvider>(context, listen: false).handleStartStop ? _cirvalue1 : 0.7)).toInt()} °C",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      progressColor: Colors.green,
    );
  }
}
