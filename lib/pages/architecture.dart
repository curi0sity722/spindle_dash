import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import "dart:math";

class ArchitecturePage extends StatefulWidget {
  const ArchitecturePage({super.key});

  @override
  State<ArchitecturePage> createState() => _ArchitecturePageState();
}

class _ArchitecturePageState extends State<ArchitecturePage> {
  Timer? _timer;
  List<double> sensorValues = List.filled(13, 0);
  final random = new Random();
  late Future<String> _modelPath;
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        for (int i = 0; i < sensorValues.length; i++) {
          sensorValues[i] = generateRandomDouble();
        }
      });
    });
  }

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
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SizedBox(
                        width: width * 0.7,
                        height: height * 0.6,
                        child: Image.asset(
                          'assets/images/spindle1.png',
                          fit: BoxFit.fill,
                        )),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.68, height * 0.30),
                          Offset(width * 0.68, height * 0.56),
                          Offset(width * 0.73, height * 0.56),
                          1.2,
                          ' Drawbar clamp/unclamp',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.48, height * 0.405),
                          Offset(width * 0.48, height * 0.59),
                          Offset(width * 0.73, height * 0.59),
                          sensorValues[7],
                          ' Rotary Encoder',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.12, height * 0.44),
                          Offset(width * 0.12, height * 0.65),
                          Offset(width * 0.73, height * 0.65),
                          sensorValues[1],
                          ' Strain Gauges',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.435, height * 0.42),
                          Offset(width * 0.435, height * 0.65),
                          Offset(width * 0.435, height * 0.65),
                          1.2,
                          '',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.13, height * 0.45),
                          Offset(width * 0.13, height * 0.62),
                          Offset(width * 0.73, height * 0.62),
                          sensorValues[0],
                          ' Accelerometers',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.425, height * 0.42),
                          Offset(width * 0.425, height * 0.62),
                          Offset(width * 0.425, height * 0.62),
                          sensorValues[3],
                          '',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.11, height * 0.45),
                          Offset(width * 0.11, height * 0.68),
                          Offset(width * 0.73, height * 0.68),
                          sensorValues[2],
                          ' Bearing Temperature',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.445, height * 0.42),
                          Offset(width * 0.445, height * 0.68),
                          Offset(width * 0.445, height * 0.68),
                          sensorValues[4],
                          '',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.25, height * 0.47),
                          Offset(width * 0.25, height * 0.71),
                          Offset(width * 0.73, height * 0.71),
                          sensorValues[7],
                          ' Motor Temperature',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.015, height * 0.32),
                          Offset(width * 0.015, height * 0.74),
                          Offset(width * 0.73, height * 0.74),
                          sensorValues[7],
                          ' Drawbar Position',
                          Color.fromARGB(255, 231, 231, 1)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(
                              width * -0.04,
                              height *
                                  0.80), //Hydrullic Power Pack ---> Controller
                          Offset(width * 0.5, height * 0.80),
                          Offset(width * 0.55, height * 0.80),
                          sensorValues[7],
                          '',
                          Color.fromARGB(255, 0, 132, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.18,
                              height * 0.85), //Lubricator ---> Controller
                          Offset(width * 0.5, height * 0.85),
                          Offset(width * 0.55, height * 0.85),
                          sensorValues[7],
                          '',
                          Color.fromARGB(255, 0, 132, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainter(
                          Offset(width * 0.365,
                              height * 0.9), //Chiller ---> Controller
                          Offset(width * 0.5, height * 0.9),
                          Offset(width * 0.55, height * 0.9),
                          sensorValues[7],
                          '',
                          Color.fromARGB(255, 0, 132, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(width * 0.01, height * 0.32),
                          Offset(width * 0.001 * -50,
                              height * 0.32), //Hydrullic Power Pack
                          Offset(width * 0.001 * -50, height * 0.82),
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(width * 0.17,
                              height * 0.42), //Oil + Air Lubrication
                          Offset(width * 0.17, height * 0.52),
                          Offset(width * 0.17, height * 0.82),
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(width * 0.34, height * 0.42), //Chiller
                          Offset(width * 0.34, height * 0.52),
                          Offset(width * 0.34, height * 0.80),
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(
                              width * 0.56, height * 0.40), //Controller (DAQ)
                          Offset(width * 0.56, height * 0.52),
                          Offset(width * 0.56, height * 0.80),
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(width * 0.57,
                              height * 0.85), //Controller ---> IIOT Dashboard
                          Offset(width * 0.67, height * 0.85),
                          Offset(width * 0.74, height * 0.85),
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    CustomPaint(
                      painter: LinePainterflow(
                          Offset(width * 0.73, height * 0.84),
                          Offset(width * 0.73, height * 0.16),
                          Offset(width * 0.65, height * 0.16),
                          Color.fromARGB(255, 251, 255, 0)),
                    ),
                    CustomPaint(
                      painter: TextPainterCustom(
                        text: 'Pressure \nOil & Temperature',
                        position: Offset(width * 0.01, height * 0.81),
                      ),
                    ),
                    CustomPaint(
                      painter: TextPainterCustom(
                        text: 'Lubrication \nPressure',
                        position: Offset(width * 0.20, height * 0.86),
                      ),
                    ),
                    CustomPaint(
                      painter: TextPainterCustom(
                        text: 'Chiller \nTemperature',
                        position: Offset(width * 0.40, height * 0.91),
                      ),
                    ),
                    Positioned(
                      // Y-coordinate
                      left: width * 0.59,
                      top: height * 0.10,
                      child: Image.asset(
                        'assets/images/network.png',
                        width: width * 0.1, // Width of the image
                        height: height * 0.1, // Height of the image
                        fit: BoxFit.contain, // Adjust based on your need
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(x / width).toStringAsFixed(2)}, ${(y / height).toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // List of image asset paths with their corresponding labels
                  ...[
                    ['assets/images/hpp.png', 'Hydraulic Power Pack (HPP)'],
                    ['assets/images/lubricator.png', 'Oil+Air Lubrication'],
                    ['assets/images/chiller.png', 'Chiller'],
                    ['assets/images/controller(daq).png', 'Controller (DAQ)'],
                    ['assets/images/dashboard.png', 'IIOT Dashboard'],
                  ].map(
                    (imageData) => Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Display the image
                          Image.asset(
                            imageData[0],
                            width: width * 0.075,
                            height: height * 0.16,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                              height:
                                  8), // Add spacing between the image and text
                          // Display the label with proper wrapping
                          Text(
                            imageData[1],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            maxLines: 2, // Limit text to 2 lines
                            overflow:
                                TextOverflow.ellipsis, // Ellipsis for overflow
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  final Color line_color;

  LinePainter(this.start, this.middle, this.end, this.sensorcolor,
      this.sensorname, this.line_color);

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
    // Color sensor_arrow_stroke_color = Color.fromARGB(255, 231, 231, 1);
    final paint = Paint()
      ..color = line_color
      ..strokeWidth = 4.0;

    // Draw lines
    canvas.drawLine(start, middle, paint);
    canvas.drawCircle(start, 8, paint..color = Colors.grey);
    canvas.drawCircle(start, 5, paint..color = getcolor(sensorcolor));
    canvas.drawLine(middle, end, paint..color = line_color);
    canvas.drawCircle(end, 3, paint..color = line_color);

    // Draw text at the end
    final textSpan = TextSpan(
      text: sensorname,
      style: TextStyle(color: Colors.white, fontSize: 15),
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

class LinePainterflow extends CustomPainter {
  final Offset start;
  final Offset middle;
  final Offset end;
  final Color linecolor;

  LinePainterflow(this.start, this.middle, this.end, this.linecolor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = linecolor
      ..strokeWidth = 6.0;

    // Draw lines
    canvas.drawLine(start, middle, paint);

    canvas.drawLine(middle, end, paint..color = linecolor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TextPainterCustom extends CustomPainter {
  final String text; // Text to paint
  final Offset position; // Position to paint the text
  final Color color; // Text color
  final double fontSize; // Text font size

  TextPainterCustom({
    required this.text,
    required this.position,
    this.color = Colors.white,
    this.fontSize = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Define text style
    final textStyle = TextStyle(
      color: color,
      fontSize: fontSize,
    );

    // Create a TextPainter
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr, // Specify text direction
    );

    // Layout the text
    textPainter.layout();

    // Paint the text at the specified position
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint only if text or position changes
    return true;
  }
}
