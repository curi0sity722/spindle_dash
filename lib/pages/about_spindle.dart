import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutSpindle extends StatefulWidget {
  const AboutSpindle({super.key});

  @override
  State<AboutSpindle> createState() => _AboutSpindleState();
}

class _AboutSpindleState extends State<AboutSpindle> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MouseRegion(
      onEnter: _incrementEnter,
      onHover: _updateLocation,
      onExit: _incrementExit,
      child: Scaffold(
        body: Column(
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
                  //Accelerometer
                  painter: LinePainter(
                    Offset(width * 0.115, height * 0.21),
                    Offset(width * 0.15, height * 0.03),
                    Offset(width * 0.2, height * 0.03),
                  ), // Example line
                ),
                CustomPaint(
                  //Temperature sensor
                  painter: LinePainter(
                    Offset(width * 0.13, height * 0.21),
                    Offset(width * 0.16, height * 0.06),
                    Offset(width * 0.22, height * 0.06),
                  ), // Example line
                ),
                CustomPaint(
                  painter: LinePainter(
                    Offset(width * 0.13, height * 0.25),
                    Offset(width * 0.17, height * 0.10),
                    Offset(width * 0.24, height * 0.10),
                  ), // Example line
                ),
                CustomPaint(
                  painter: LinePainter(
                    Offset(width * 0.425, height * 0.42),
                    Offset(width * 0.45, height * 0.64),
                    Offset(width * 0.53, height * 0.64),
                  ),
                  // Example line
                ),
              ],
            ),
            Text(
              'The cursor is here: (${(x / width).toStringAsFixed(2)}, ${((y / height) - 0.1).toStringAsFixed(2)})',
            ),
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

  LinePainter(this.start, this.middle, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0;

    canvas.drawLine(start, middle, paint);
    canvas.drawCircle(start, 7, paint..color = Colors.black);
    canvas.drawLine(middle, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
