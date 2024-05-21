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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircularGraph(text: 'V'),
                        SizedBox(height: height * 0.02,),
                        Text('Spindle Input Voltage in V')
                      ],
                    ),
                    SizedBox(width: width * 0.15,),
                    Column(
                      children: [
                        CircularGraph(text: 'A'),
                        SizedBox(height: height * 0.02,),
                        Text('Spindle Current in Amps')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.1,),
                CircularGraph(text: 'kWh'),
                SizedBox(height: height * 0.02,),
                Text('Spindle Energy in kWh')
              ],
            ),
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
  int index = 0;
  final List<TimeSeriesData> chartData = [
      // TimeSeriesData(DateTime(2023, 1, 1), 30, 40, 50),
      // TimeSeriesData(DateTime(2023, 1, 2), 35, 45, 55),
      // TimeSeriesData(DateTime(2023, 1, 3), 40, 50, 60),
      // TimeSeriesData(DateTime(2023, 1, 4), 45, 55, 65),
      // TimeSeriesData(DateTime(2023, 1, 5), 50, 60, 70),
    ];
    Timer? _timer;

  void initState() {
    super.initState();
    Timer.periodic(Duration(microseconds: 500), (timer) {
      if (mounted) {
        // Check if widget is still mounted
        setState(() {
          if (Provider.of<InitialDurationProvider>(context, listen: false)
              .handleStartStop) {
            updatelinegraph();
            index += 1;
          } else {
            linegraph();
          }
        });
      }
    });
  }

  final Random random = Random();

  double _getRandomInt(int min, int max) {
    return (min + random.nextInt(max - min)) as double;
  }

  /// Method to update the chart data.

  List<TimeSeriesData> updatelinegraph() {
    setState(() {
      if (chartData.length <= 6) {
        chartData.add(
          TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(10, 70),
              _getRandomInt(20, 80), _getRandomInt(30, 90)),
        );
      } else {
        chartData.removeAt(0);
        chartData.add(
          TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(10, 70),
              _getRandomInt(20, 80), _getRandomInt(30, 90)),
        );
      }
    });
    return chartData;
  }

  List<TimeSeriesData> linegraph() {
    return chartData;
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer in dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Container(
      width: width * 0.35,
      height: height * 0.5,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(text: 'time in minutes'),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Spindle power in kWh')
        ),
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
  final String text; // Add a parameter to accept a string

  const CircularGraph({Key? key, required this.text}) : super(key: key);

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
        _cirvalue2 = 0.1 + (random.nextDouble() * (0.32 - 0.29));
        _cirvalue3 = 0.025 + (random.nextDouble() * (0.52 - 0.49));
      });
    });
  }

  double _getValueBasedOnText(String text) {
    switch (text) {
      case 'V':
        return _cirvalue1;
      case 'A':
        return _cirvalue2;
      case 'kWh':
        return _cirvalue3;
      default:
        return _cirvalue1; // Default to value1 if text doesn't match
    }
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
          ? _getValueBasedOnText(widget.text)
          : 0.7,
      center: Text(
         "${(415 * (Provider.of<InitialDurationProvider>(context, listen: false).handleStartStop ? _getValueBasedOnText(widget.text) : 0.7)).toInt()} ${widget.text}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      progressColor: Colors.green,
    );
  }
}
