import 'dart:async';
import 'package:flutter/material.dart';
import "dart:math";
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:spindle_dash/api/fetchdata.dart';

class AboutSpindle extends StatefulWidget {
  const AboutSpindle({super.key});

  @override
  State<AboutSpindle> createState() => _AboutSpindleState();
}

class _AboutSpindleState extends State<AboutSpindle> {
  final random = new Random();
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;
  Timer? _timer;
  late String threedmodelpath;
  List<double> sensorValues = List.filled(8, 0);
  // double sensorValue1 = 0.0;
  // double sensorValue2 = 0.0;
  // double sensorValue3 = 0.0;
  // double sensorValue4 = 0.0;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize sensor values
    // sensorValue1 = generateRandomDouble();
    // sensorValue2 = generateRandomDouble();
    // sensorValue3 = generateRandomDouble();
    // sensorValue4 = generateRandomDouble();

    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        // sensorValue1 = generateRandomDouble();
        // sensorValue2 = generateRandomDouble();
        // sensorValue3 = generateRandomDouble();
        // sensorValue4 = generateRandomDouble();
        for (int i = 0; i < sensorValues.length; i++) {
          sensorValues[i] = generateRandomDouble();
        }
      });
    });
    setState(() {
      FutureBuilder(
        future: FireStoreDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network(
              threedmodelpath = snapshot.data.toString(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double generateRandomDouble() {
    return random.nextDouble() * 5;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MouseRegion(
      onEnter: _incrementEnter,
      onHover: _updateLocation,
      onExit: _incrementExit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    width: width * 0.7,
                    height: height * 0.6,
                    child: Image.asset(
                      'assets/images/spindle1.png',
                      fit: BoxFit.fill,
                    )),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.115, height * 0.21),
                      Offset(width * 0.15, height * 0.03),
                      Offset(width * 0.2, height * 0.03),
                      sensorValues[0],
                      'Force Sensor (Spindle Front)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.13, height * 0.21),
                      Offset(width * 0.16, height * 0.06),
                      Offset(width * 0.22, height * 0.06),
                      sensorValues[1],
                      'Vibration Sensor (Spindle Front)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.14, height * 0.235),
                      Offset(width * 0.17, height * 0.10),
                      Offset(width * 0.24, height * 0.10),
                      sensorValues[2],
                      'Bearing Temperature (Spindle Front)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.425, height * 0.42),
                      Offset(width * 0.45, height * 0.64),
                      Offset(width * 0.53, height * 0.64),
                      sensorValues[3],
                      'Force Sensor (Spindle Rear)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.44, height * 0.42),
                      Offset(width * 0.46, height * 0.60),
                      Offset(width * 0.55, height * 0.60),
                      sensorValues[4],
                      'Vibration Sensor (Spindle Rear)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.45, height * 0.40),
                      Offset(width * 0.47, height * 0.56),
                      Offset(width * 0.57, height * 0.56),
                      1.2,
                      'Bearing Temperature (Spindle Rear)'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.52, height * 0.24),
                      Offset(width * 0.53, height * 0.18),
                      Offset(width * 0.57, height * 0.18),
                      1.2,
                      'Coolant Inlet Temperature'),
                ),
                CustomPaint(
                  painter: LinePainter(
                      Offset(width * 0.52, height * 0.44),
                      Offset(width * 0.53, height * 0.50),
                      Offset(width * 0.57, height * 0.50),
                      sensorValues[7],
                      'Coolant Outlet Temperature'),
                ),
              ],
            ),
            // Text(
            //   'The cursor is here: (${(x / width).toStringAsFixed(2)}, ${((y / height) - 0.1).toStringAsFixed(2)})',
            // ),

            Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Specifications:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TableWidget(),
                  Container(
                    height: height * 0.45,
                    width: width * 0.30,
                    child: FutureBuilder(
                      future: FireStoreDataBase().getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                            "Something went wrong",
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ModelViewer(
                            interactionPrompt: InteractionPrompt.none,
                            cameraOrbit: "0deg 100deg 105%",
                            backgroundColor: Colors.white,
                            src: threedmodelpath,

                            //  src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                            alt: 'A 3D model of an astronaut',
                            ar: true,
                            autoRotate: true,

                            disableZoom: true,
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset middle;
  final Offset end;
  final double sensorcolor;
  final String sensorname;

  LinePainter(
      this.start, this.middle, this.end, this.sensorcolor, this.sensorname);

  Color getcolor(value) {
    if (value <= 1.5) {
      return Colors.green;
    } else if (value > 1.5 && value < 2.5) {
      return Colors.yellow.shade700;
    } else {
      return Colors.red;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0;

    // Draw lines
    canvas.drawLine(start, middle, paint);
    canvas.drawCircle(start, 8, paint..color = Colors.black);
    canvas.drawCircle(start, 5, paint..color = getcolor(sensorcolor));
    canvas.drawLine(middle, end, paint..color = Colors.black);
    canvas.drawCircle(end, 3, paint..color = Colors.black);

    // Draw text at the end
    final textSpan = TextSpan(
      text: sensorname,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    final textOffset = Offset(end.dx + 5, end.dy - textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<String> Parameters = [
    'Power',
    'Rated Torque',
    'Rated Speed',
    'Maximum Speed',
    'Rated Current',
    'Maximum Current',
    'Balancing class'
  ];
  List<String> Specification = [
    '15.5 kW',
    '42 Nm',
    '3500 RPM',
    '20000 RPM',
    '42 A',
    '84 A',
    'G1'
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Cell('SL NO', width * 0.05, height * 0.04, true, true),
            for (int i = 1; i < 8; i++)
              Cell('$i', width * 0.05, height * 0.04, false, true)
          ],
        ),
        Column(
          children: [
            Cell('Parameters', width * 0.15, height * 0.04, true, false),
            for (int i = 0; i < Parameters.length; i++)
              Cell(
                  '${Parameters[i]}', width * 0.15, height * 0.04, false, false)
          ],
        ),
        Column(
          children: [
            Cell('Specifications', width * 0.08, height * 0.04, true, false),
            for (int i = 0; i < Parameters.length; i++)
              Cell('${Specification[i]}', width * 0.08, height * 0.04, false,
                  false)
          ],
        )
      ],
    );
  }

  Widget Cell(text, width, height, FirstColumnCheck, CenterOrStartCheck) {
    return Container(
      width: width,
      height: height,
      color: FirstColumnCheck ? Colors.blueGrey : Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: CenterOrStartCheck
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                color: FirstColumnCheck ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
