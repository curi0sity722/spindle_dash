import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class Temperature_monitoring extends StatefulWidget {
  const Temperature_monitoring({super.key});

  @override
  State<Temperature_monitoring> createState() => _Temperature_monitoringState();
}

class _Temperature_monitoringState extends State<Temperature_monitoring> {
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
    return Row(
      children: [
        Column(
          children: [
             CircularPercentIndicator(
                      radius: (7 / 100) *
                          min(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                      lineWidth: 10.0,
                      percent: Provider.of<InitialDurationProvider>(context, listen: false)
                            .handleStartStop ? _cirvalue1 : 0.7,
                      center: Text(
                        "${(100 * (Provider.of<InitialDurationProvider>(context, listen: false)
                            .handleStartStop ? _cirvalue1 : 0.7)).toInt()} °C",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      progressColor: Colors.green,
                    ),
          ],
        )
      ],
    );
  }
}