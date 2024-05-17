import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spindle_dash/pages/energy_monitoring.dart';
import 'package:spindle_dash/pages/force_monitoring.dart';
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

class _spindledashboardState extends State<spindledashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabList = [
    Tab(icon: Icon(Icons.vibration), text: 'Vibration Monitoring'),
    Tab(icon: Icon(Icons.thermostat), text: 'Temperature Monitoring'),
    Tab(icon: Icon(Icons.electrical_services), text: 'Energy Monitoring'),
    Tab(icon: Icon(Icons.fitness_center), text: 'Force Monitoring'),
    Tab(
        icon: Icon(Icons.settings_accessibility),
        text: 'Vibration Diagnostics'),
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

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  bool _isRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Integrated Motor Spindle DashBoard'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0), // Adjust height as needed
          child: TabBar(
            controller: _tabController,
            isScrollable: true, // Enable scrolling if tabs overflow
            labelColor: Colors.white, // Customize label color
            unselectedLabelColor:
                Colors.white54, // Customize unselected label color
            indicator: BoxDecoration(
              // Customize tab indicator
              color: Colors.blue, // Change color
              borderRadius: BorderRadius.circular(10.0), // Add border radius
            ),
            tabs: _tabList,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _toggleTimer();
              Provider.of<InitialDurationProvider>(context, listen: false)
                  .setstartstop(_isRunning);
              // print(Provider.of<InitialDurationProvider>(context, listen: false).handleStartStop);
            },
            //onPressed: _toggleTimer,
            child: Text(
                Provider.of<InitialDurationProvider>(context, listen: false)
                        .handleStartStop
                    ? 'Stop'
                    : 'Start'),
            style: ButtonStyle(
                backgroundColor:
                    Provider.of<InitialDurationProvider>(context, listen: false)
                            .handleStartStop
                        ? MaterialStateProperty.all<Color>(Colors.red)
                        : MaterialStateProperty.all<Color>(Colors.green)),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: VibrationMonitoring()),
          Center(child: Temperature_monitoring()),
          Center(child: EnergyMonitoring()),
          Center(child: ForceMonitoring()),
          Center(child: Text('Vibration Diagnostics')),
        ],
      ),
    );
  }
}