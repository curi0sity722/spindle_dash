import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:spindle_dash/provider/user_provider.dart';

class VibrationMonitoring extends StatefulWidget {
  const VibrationMonitoring({super.key});

  @override
  State<VibrationMonitoring> createState() => _VibrationMonitoringState();
}

class _VibrationMonitoringState extends State<VibrationMonitoring> {
  final Random random = Random();
  num _getRandomInt(int min, int max) {
    return min + random.nextInt(max - min);
  }

  List<List<_ChartShaderData>> chartdata = [
    [
      _ChartShaderData('X', 10, '100%'),
      _ChartShaderData('Y', 11, '100%'),
      _ChartShaderData('Z', 12, '100%'),
    ],
    [
      _ChartShaderData('X', 10, '100%'),
      _ChartShaderData('Y', 11, '100%'),
      _ChartShaderData('Z', 12, '100%'),
    ],
  ];

  Timer? _timer;

  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        chartdata[0] = [
          _ChartShaderData('X', _getRandomInt(5, 10), '100%'),
          _ChartShaderData('Y', _getRandomInt(3, 8), '100%'),
          _ChartShaderData('Z', _getRandomInt(1, 6), '100%'),
        ];
        chartdata[1] = [
          _ChartShaderData('X', _getRandomInt(5, 10), '100%'),
          _ChartShaderData('Y', _getRandomInt(3, 8), '100%'),
          _ChartShaderData('Z', _getRandomInt(1, 6), '100%'),
        ];
      });
      // Call your function here
    });
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
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         for (var data in chartdata)
    //           RadialWdget(
    //             radialchartdata: data,
    //           ),
    //       ],
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [LineGraph(), LineGraph()],
    //     )
    //   ],
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                RadialWdget(
                  radialchartdata: chartdata[0],
                ),
                Text('Spindle (F)'),
                SizedBox(
                  height: height * 0.01,
                ),
                Text('Vibration Level (RMS)')
              ],
            ),
            Column(
              children: [LineGraph(), Text('time in min\nSpindle (F)')],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                RadialWdget(
                  radialchartdata: chartdata[1],
                ),
                Text('Spindle (R)'),
              ],
            ),
            Column(
              children: [LineGraph(), Text('time in min\nSpindle (R)')],
            )
          ],
        )
      ],
    );
  }
}

class _ChartShaderData {
  _ChartShaderData(this.x, this.y, this.text);

  final String x;
  final num y;
  final String text;
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
      width: width * 0.25,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(title: AxisTitle()),
        primaryYAxis:
            NumericAxis(title: AxisTitle(text: 'Vibration level in mm/sec')),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<TimeSeriesData, DateTime>(
            name: 'X',
            dataSource: chartData,
            xValueMapper: (TimeSeriesData data, _) => data.time,
            yValueMapper: (TimeSeriesData data, _) => data.value1,
            markerSettings: MarkerSettings(isVisible: true),
          ),
          LineSeries<TimeSeriesData, DateTime>(
            name: 'Y',
            dataSource: chartData,
            xValueMapper: (TimeSeriesData data, _) => data.time,
            yValueMapper: (TimeSeriesData data, _) => data.value2,
            markerSettings: MarkerSettings(isVisible: true),
          ),
          LineSeries<TimeSeriesData, DateTime>(
            name: 'Z',
            dataSource: chartData,
            xValueMapper: (TimeSeriesData data, _) => data.time,
            yValueMapper: (TimeSeriesData data, _) => data.value3,
            markerSettings: MarkerSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

// class LineGraph extends StatefulWidget {
//   const LineGraph({super.key});

//   @override
//   State<LineGraph> createState() => _LineGraphState();
// }

// class _LineGraphState extends State<LineGraph> {
//   @override
//   Widget build(BuildContext context) {
//     bool thc1_pressed = false;
//     bool thc2_pressed = false;

//     double _value1 = 0.0;
//     double _value2 = 12.0;
//     int index = 0;
//     List<ChartSampleData> chartData = <ChartSampleData>[
//       // ChartSampleData(x: 1, y: 30),
//       // ChartSampleData(x: 3, y: 13),
//       // ChartSampleData(x: 5, y: 80),
//       // ChartSampleData(x: 7, y: 30),
//       // ChartSampleData(x: 9, y: 72)
//     ];
//     final Random random = Random();

//     /// Method to update the chart data.

//     num _getRandomInt(int min, int max) {
//       return min + random.nextInt(max - min);
//     }

//     List<ChartSampleData> updatelinegraph() {
//       setState(() {
//         if (chartData.length <= 6) {
//           chartData.add(ChartSampleData(index, _getRandomInt(10, 100)));
//         } else {
//           chartData.removeAt(0);
//           chartData.add(ChartSampleData(index, _getRandomInt(10, 100)));
//         }
//       });
//       return chartData;
//     }

//     List<ChartSampleData> linegraph() {
//       return chartData;
//     }

//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (Provider.of<InitialDurationProvider>(context, listen: false)
//             .handleStartStop) {
//           updatelinegraph();
//           index += 1;
//         } else {
//           linegraph();
//         }
//       });
//       // Call your function here
//     });
//     return SfCartesianChart(
//       primaryXAxis: NumericAxis(),
//       primaryYAxis: NumericAxis(),
//       series: <LineSeries<ChartSampleData, num>>[
//         LineSeries<ChartSampleData, num>(
//             dataSource: chartData,
//             xValueMapper: (ChartSampleData data, _) => data.x,
//             yValueMapper: (ChartSampleData data, _) => data.y,
//             dataLabelSettings: DataLabelSettings(isVisible: true)),
//       ],
//     );
//   }
// }

class TimeSeriesData {
  TimeSeriesData(this.time, this.value1, this.value2, this.value3);

  final DateTime time;
  final double value1;
  final double value2;
  final double value3;
}

class RadialWdget extends StatefulWidget {
  final List<_ChartShaderData> radialchartdata;

  const RadialWdget({
    Key? key,
    required this.radialchartdata,
  }) : super(key: key);

  @override
  State<RadialWdget> createState() => _RadialWdgetState();
}

class _RadialWdgetState extends State<RadialWdget> {
  final List<Color> colors = const [Colors.green, Colors.yellow, Colors.red];
  final List<double> stops = const [0.2, 0.4, 0.9];
  final TooltipBehavior tooltipBehavior =
      TooltipBehavior(enable: true, format: 'point.x : point.y');

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      key: GlobalKey(),
      onCreateShader: (ChartShaderDetails chartShaderDetails) {
        return ui.Gradient.sweep(
          chartShaderDetails.outerRect.center,
          colors,
          stops,
          TileMode.clamp,
          _degreeToRadian(0),
          _degreeToRadian(360),
          _resolveTransform(chartShaderDetails.outerRect, TextDirection.ltr),
        );
      },
      series: _getRadialBarGradientSeries(widget.radialchartdata),
      tooltipBehavior: tooltipBehavior,
    );
  }

  List<RadialBarSeries<_ChartShaderData, String>> _getRadialBarGradientSeries(
      List<_ChartShaderData> data) {
    return <RadialBarSeries<_ChartShaderData, String>>[
      RadialBarSeries<_ChartShaderData, String>(
        maximumValue: 15,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10.0)),
        dataSource: data,
        cornerStyle: CornerStyle.bothCurve,
        gap: '10%',
        radius: '90%',
        xValueMapper: (_ChartShaderData data, _) => data.x,
        yValueMapper: (_ChartShaderData data, _) => data.y,
        pointRadiusMapper: (_ChartShaderData data, _) => data.text,
        dataLabelMapper: (_ChartShaderData data, _) => data.x,
        animationDuration: 0,
      ),
    ];
  }

  dynamic _resolveTransform(Rect bounds, TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);
}
