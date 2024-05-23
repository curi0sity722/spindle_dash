import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../provider/user_provider.dart';

class Temperature_monitoring extends StatefulWidget {
  const Temperature_monitoring({super.key});

  @override
  State<Temperature_monitoring> createState() => _Temperature_monitoringState();
}

class _Temperature_monitoringState extends State<Temperature_monitoring> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircularGraph(
                  initialValue: 'spindlefront',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Temperature in °C'),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Spindle (F) Bearing',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Spindle (F) Bearing Temperature',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                LineGraph(
                  initialValue: 'spindlefront',
                ),
                Text('time in min')
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircularGraph(
                  initialValue: 'spindlerear',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Temperature in °C'),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Spindle (R) Bearing',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Spindle (F) Bearing Temperature',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                LineGraph(
                  initialValue: 'spindlerear',
                ),
                Text('time in min')
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircularGraph(
                  initialValue: 'coolantinlet',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Temperature in °C'),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Coolant inlet',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Coolant inlet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                LineGraph(
                  initialValue: 'coolantinlet',
                ),
                Text('Temperature in °C'),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircularGraph(
                  initialValue: 'coolantoutlet',
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Temperature in °C'),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Coolant outlet',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Coolant outlet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                LineGraph(
                  initialValue: 'coolantoutlet',
                ),
                Text('Temperature in °C')
              ],
            ),
            // Image.asset('assets/cmti.jpg'),
          ],
        )
      ],
    );
  }
}

class TimeSeriesData {
  TimeSeriesData(this.time, this.value1);

  final DateTime time;
  final double value1;
  
}

class LineGraph extends StatefulWidget {
  final String initialValue;
  const LineGraph({super.key, required this.initialValue});

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
      switch (widget.initialValue) {
        case 'spindlefront':
          {
            if (chartData.length <= 6) {
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(48, 52),
                    ),
              );
            } else {
              chartData.removeAt(0);
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(48, 52),
                    ),
              );
            }
          }
          break;

        case 'spindlerear':
          {
            if (chartData.length <= 6) {
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(48, 52),
                    ),
              );
            } else {
              chartData.removeAt(0);
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(48, 52),
                    ),
              );
            }
          }
          break;

        case 'coolantinlet':
          {
            if (chartData.length <= 6) {
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(28, 32),
                    ),
              );
            } else {
              chartData.removeAt(0);
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(28, 32),
                    ),
              );
            }
          }
          break;

        case 'coolantoutlet':
          {
            if (chartData.length <= 6) {
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(44, 48),
                    ),
              );
            } else {
              chartData.removeAt(0);
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(44, 48),
                    ),
              );
            }
          }
          break;

        default:
          {
            if (chartData.length <= 6) {
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(0, 0),
                    ),
              );
            } else {
              chartData.removeAt(0);
              chartData.add(
                TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(0, 0),
                    ),
              );
            }
          }
          break;
      }
      // if (chartData.length <= 6) {
      //   chartData.add(
      //     TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(0, 1),
      //         ),
      //   );
      // } else {
      //   chartData.removeAt(0);
      //   chartData.add(
      //     TimeSeriesData(DateTime(2023, 1, index), _getRandomInt(0, 1),
      //         ),
      //   );
      // }
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
      width: width * 0.25,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Temperature in °C')),
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
  final String initialValue;
  const CircularGraph({super.key, required this.initialValue});

  @override
  State<CircularGraph> createState() => _CircularGraphState();
}

class _CircularGraphState extends State<CircularGraph> {
  double _cirvalue1 = 0.0; // Your initial value
  // double _cirvalue2 = 0.0;
  // double _cirvalue3 = 0.0;

  @override
  void initState() {
    super.initState();
    // Start a timer to update the values every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final random = Random();
        switch (widget.initialValue) {
          case 'spindlefront':
            {
              _cirvalue1 = 0.49 + (random.nextDouble() * (0.52 - 0.49));
            }
            break;

          case 'spindlerear':
            {
              _cirvalue1 = 0.50 + (random.nextDouble() * (0.53 - 0.50));
            }
            break;

          case 'coolantinlet':
            {
              _cirvalue1 = 0.29 + (random.nextDouble() * (0.32 - 0.29));
            }
            break;

          case 'coolantoutlet':
            {
              _cirvalue1 = 0.44 + (random.nextDouble() * (0.48 - 0.44));
            }
            break;

          default:
            {
              _cirvalue1 = 0;
            }
            break;
        }

        // _cirvalue2 = 0.29 + (random.nextDouble() * (0.32 - 0.29));
        // _cirvalue3 = 0.49 + (random.nextDouble() * (0.52 - 0.49));
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
          : 0.0,
      center: Text(
        "${(100 * (Provider.of<InitialDurationProvider>(context, listen: false).handleStartStop ? _cirvalue1 : 0.0)).toInt()} °C",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      progressColor: Colors.green,
    );
  }
}
