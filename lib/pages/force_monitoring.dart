import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../provider/user_provider.dart';

class ForceMonitoring extends StatefulWidget {
  const ForceMonitoring({super.key});

  @override
  State<ForceMonitoring> createState() => _ForceMonitoringState();
}

class _ForceMonitoringState extends State<ForceMonitoring> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly  ,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Row(
            //   children: [

            //   ],
            // ),
            Column(
              children: [
                CircularGraph(),
                SizedBox(height: height * 0.02,),
                Text('Force at Spindle(F) in Newton')
              ],
            ),
            LineGraph(yaxistitle: 'Force at Spindle (F) in Newtons'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircularGraph(),
                SizedBox(height: height * 0.02,),
                Text('Force at Spindle(R) in Newton')
              ],
            ),
            LineGraph(yaxistitle: 'Force at Spindle (R) in Newtons',),
          ],
        ),
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
  String yaxistitle;
  LineGraph({super.key,required this.yaxistitle,});

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  int index = 0;
  var formatterTime = DateFormat('kk:mm');
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
    Timer.periodic(Duration(microseconds: 700), (timer) {
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
          TimeSeriesData(DateTime.now(), _getRandomInt(69, 72),
              _getRandomInt(20, 80), _getRandomInt(30, 90)),
        );
      } else {
        chartData.removeAt(0);
        chartData.add(
          TimeSeriesData(DateTime.now(), _getRandomInt(69, 72),
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
      width: width * 0.30,
      height: height * 0.4,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hms(),
          title: AxisTitle(text: 'time in seconds')
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: widget.yaxistitle)
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
      radius: (10 / 100) *
          min(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
      lineWidth: 15.0,
      percent: Provider.of<InitialDurationProvider>(context, listen: false)
              .handleStartStop
          ? _cirvalue1
          : 0.7,
      center: Text(
        "${(100 * (Provider.of<InitialDurationProvider>(context, listen: false).handleStartStop ? _cirvalue1 : 0.7)).toInt()} N",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      progressColor: Colors.green,
    );
  }
}
