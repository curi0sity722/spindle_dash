import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:spindle_dash/pages/energy_monitoring.dart';
import 'package:spindle_dash/pages/force_monitoring.dart';
import 'package:spindle_dash/pages/temperature_monitoring.dart';
import 'package:spindle_dash/pages/vibration_analysis.dart';
import 'package:spindle_dash/pages/vibration_monitoring.dart';

class Subswitcher1 extends StatefulWidget {
  const Subswitcher1({super.key});

  @override
  State<Subswitcher1> createState() => _Subswitcher1State();
}

class _Subswitcher1State extends State<Subswitcher1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            length: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonsTabBar(
                  backgroundColor: Colors.red,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                        icon: Icon(Icons.vibration),
                        text: 'Vibration Monitoring'),
                    Tab(
                        icon: Icon(Icons.thermostat),
                        text: 'Temperature Monitoring'),
                    Tab(
                        icon: Icon(Icons.electrical_services),
                        text: 'Energy Monitoring'),
                    Tab(
                        icon: Icon(Icons.fitness_center),
                        text: 'Force Monitoring'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: VibrationMonitoring(),
                      ),
                      Center(
                        child: Temperature_monitoring(),
                      ),
                      Center(
                        child: EnergyMonitoring(),
                      ),
                      Center(
                        child: ForceMonitoring(),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Subswitcher2 extends StatefulWidget {
  const Subswitcher2({super.key});

  @override
  State<Subswitcher2> createState() => _Subswitcher2State();
}

class _Subswitcher2State extends State<Subswitcher2> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            length: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonsTabBar(
                  backgroundColor: Colors.red,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                        icon: Icon(Icons.health_and_safety),
                        text: 'Vibration Diagnosis'),
                    Tab(
                        icon: Icon(Icons.thermostat),
                        text: 'Temperature Diagnosis'),
                    Tab(
                        icon: Icon(Icons.electrical_services),
                        text: 'Energy Diagnosis'),
                    
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: VibrationAnalysis(),
                      ),
                      Center(
                        child: Scaffold(),
                      ),
                      Center(
                        child: Scaffold(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}