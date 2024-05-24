import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:spindle_dash/provider/user_provider.dart';
import 'package:intl/intl.dart' as datetimeformat;

class VibrationMonitoring extends StatefulWidget {
  const VibrationMonitoring({super.key});

  @override
  State<VibrationMonitoring> createState() => _VibrationMonitoringState();
}

class _VibrationMonitoringState extends State<VibrationMonitoring> {
  final Random random = Random();

  num x1 = 0, x2 = 0, y1 = 0, y2 = 0, z1 = 0, z2 = 0;

  num _getRandomInt(int min, int max) {
    return min + random.nextInt(max - min);
  }

  List<List<_ChartShaderData>> chartdata = [
    [
      _ChartShaderData('X', 0, '100%'),
      _ChartShaderData('Y', 0, '100%'),
      _ChartShaderData('Z', 0, '100%'),
    ],
    [
      _ChartShaderData('X', 0, '100%'),
      _ChartShaderData('Y', 0, '100%'),
      _ChartShaderData('Z', 0, '100%'),
    ],
  ];

  Timer? _timer;

  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        x1 = _getRandomInt(1, 5);
        y1 = _getRandomInt(1, 5);
        z1 = _getRandomInt(1, 5);
        x2 = _getRandomInt(1, 5);
        y2 = _getRandomInt(1, 5);
        z2 = _getRandomInt(1, 5);
        chartdata[0] = [
          _ChartShaderData('X', x1, '100%'),
          _ChartShaderData('Y', y1, '100%'),
          _ChartShaderData('Z', z1, '100%'),
        ];
        chartdata[1] = [
          _ChartShaderData('X', x2, '100%'),
          _ChartShaderData('Y', y2, '100%'),
          _ChartShaderData('Z', z2, '100%'),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          RadialWdget(
                            radialchartdata: chartdata[0],
                          ),
                        ],
                      ),
                      Text('Vibration Level in mm/sec (rms)'),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Spindle (F)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  limitwidget(height, width, true)
                ],
              ),
              Column(
                children: [LineGraph()],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          RadialWdget(
                            radialchartdata: chartdata[1],
                          ),
                          Text('Vibration Level in mm/sec (rms) '),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            'Spindle (R)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      limitwidget(height, width, false)
                    ],
                  ),
                ],
              ),
              Column(
                children: [LineGraph()],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget limitwidget(height, width, selectioninteger) {
    Color getcolor(value) {
      if (value <= 1.5) {
        return Colors.green;
      } else if (value > 1.5 && value < 2.5) {
        return Colors.yellow.shade700;
      } else {
        return Colors.red;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height * 0.1,
          width: width * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.015,
                    height: height * 0.015,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Replace with your desired color
                    ),
                  ),
                  Text(' -- ', overflow: TextOverflow.fade),
                  Text('Good', overflow: TextOverflow.fade)
                ],
              ),
              Row(
                children: [
                  Container(
                    width: width * 0.015,
                    height: height * 0.015,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow, // Replace with your desired color
                    ),
                  ),
                  Text(' -- ', overflow: TextOverflow.fade),
                  Text('Tolerable', overflow: TextOverflow.fade)
                ],
              ),
              Row(
                children: [
                  Container(
                    width: width * 0.015,
                    height: height * 0.015,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red, // Replace with your desired color
                    ),
                  ),
                  Text(' -- ', overflow: TextOverflow.fade),
                  Text('Not Tolerable', overflow: TextOverflow.fade)
                ],
              )
            ],
          ),
        ),
        Container(
          height: height * 0.1,
          width: width * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'X',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selectioninteger ? x1 : x2} mm/sec',
                    style:
                        TextStyle(color: getcolor(selectioninteger ? x1 : x2)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Y',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selectioninteger ? y1 : y2} mm/sec',
                    style:
                        TextStyle(color: getcolor(selectioninteger ? y1 : y2)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Z',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selectioninteger ? z1 : z2} mm/sec',
                    style:
                        TextStyle(color: getcolor(selectioninteger ? z1 : z2)),
                  )
                ],
              )
            ],
          ),
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

  List<TimeSeriesData> updatelinegraph() {
    setState(() {
      if (chartData.length <= 6) {
        chartData.add(
          TimeSeriesData(DateTime.now(), _getRandomInt(10, 70),
              _getRandomInt(20, 80), _getRandomInt(30, 90)),
        );
      } else {
        chartData.removeAt(0);
        chartData.add(
          TimeSeriesData(DateTime.now(), _getRandomInt(10, 70),
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
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: datetimeformat.DateFormat.Hms(),
          title: AxisTitle(text: 'time in sec'),
        ),
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
  final List<double> stops = const [0.30, 0.50, 0.9];
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
        maximumValue: 5,
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
