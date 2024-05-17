import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spindle_dash/pages/temperature_monitoring.dart';
import 'package:spindle_dash/pages/vibration_monitoring.dart';
import 'package:spindle_dash/provider/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InitialDurationProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: spindledashboard()),
    );
  }
}

class spindledashboard extends StatefulWidget {
  const spindledashboard({super.key});

  @override
  State<spindledashboard> createState() => _spindledashboardState();
}

class _spindledashboardState extends State<spindledashboard> with TickerProviderStateMixin {
late TabController _tabController;
  final List<Widget> _tabList = [
    Tab(icon: Icon(Icons.vibration), text: 'Vibration Monitoring'),
    Tab(icon: Icon(Icons.thermostat), text: 'Temperature Monitoring'),
    Tab(icon: Icon(Icons.electrical_services), text: 'Energy Monitoring'),
    Tab(icon: Icon(Icons.fitness_center), text: 'Force Monitoring'),
    Tab(icon: Icon(Icons.settings_accessibility), text: 'Vibration Diagnostics'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Smart Integrated Motor Spindle DashBoard'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0), // Adjust height as needed
          child: TabBar(
            controller: _tabController,
            isScrollable: true, // Enable scrolling if tabs overflow
            labelColor: Colors.white, // Customize label color
            unselectedLabelColor: Colors.white54, // Customize unselected label color
            indicator: BoxDecoration( // Customize tab indicator
              color: Colors.blue, // Change color
              borderRadius: BorderRadius.circular(10.0), // Add border radius
            ),
            tabs: _tabList,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Replace with your content for each tab
          Center(child: VibrationMonitoring()),
          Center(child: Temperature_monitoring()),
          Center(child: Text('Energy Monitoring')),
          Center(child: Text('Force Monitoring')),
          Center(child: Text('Vibration Diagnostics')),
        ],
      ),
    );
  }
}