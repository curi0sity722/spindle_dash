import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';
import 'package:spindle_dash/pages/about_spindle.dart';
import 'package:spindle_dash/pages/architecture.dart';
import 'package:spindle_dash/pages/energy_monitoring.dart';
import 'package:spindle_dash/pages/force_monitoring.dart';
import 'package:spindle_dash/pages/switchtabspage.dart';
import 'package:spindle_dash/pages/temperature_monitoring.dart';
import 'package:spindle_dash/pages/vibration_analysis.dart';
import 'package:spindle_dash/pages/vibration_monitoring.dart';
import 'package:spindle_dash/provider/user_provider.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'firebase_options.dart';

import 'dart:math' as math show pi;

void main() {
    WidgetsFlutterBinding.ensureInitialized();
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
                scaffoldBackgroundColor: Colors.black),
            home: Scaffold(
              body: spindledashboard(),
            )));
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
    Tab(icon: Icon(Icons.perm_device_information), text: 'About Spindle'),
    Tab(icon: Icon(Icons.architecture), text: 'Architecture'),
    Tab(icon: Icon(Icons.health_and_safety), text: 'Health Monitoring'),
    Tab(icon: Icon(Icons.analytics), text: 'Analysis and Diagnosis'),
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
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            // Image.asset('assets/cmti.jpeg'),
            Text(
              'Smart Integrated Motor Spindle DashBoard',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45.0), // Adjust height as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true, // Enable scrolling if tabs overflow
                labelColor: Colors.white, // Customize label color
                unselectedLabelColor:
                    Colors.white54, // Customize unselected label color
                indicator: BoxDecoration(
                  // Customize tab indicator
                  color: Colors.blue, // Change color
                  borderRadius:
                      BorderRadius.circular(10.0), // Add border radius
                ),
                tabs: _tabList,
              ),
              // Text('CMTI')
            ],
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
                        ? WidgetStateProperty.all<Color>(Colors.red)
                        : WidgetStateProperty.all<Color>(Colors.green)),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Center(child: AboutPagetest()),
          Center(
            child: AboutSpindle(),
          ),
          Center(child: ArchitecturePage()),
          Center(child: Subswitcher1()),
          Center(child: Subswitcher2()),
        ],
      ),
    );
  }
}

class AboutPagetest extends StatefulWidget {
  const AboutPagetest({super.key});

  @override
  State<AboutPagetest> createState() => _AboutPagetestState();
}

class _AboutPagetestState extends State<AboutPagetest> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ModelViewer(
      backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
      // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
      src:
          "https://firebasestorage.googleapis.com/v0/b/dos1-23caf.appspot.com/o/Spindle.gltf?alt=media&token=ac3e2e4b-c7c2-4138-8153-740857562a07",
      alt: 'A 3D model of an astronaut',
      ar: true,
      autoRotate: true,
      iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: true,
    ));
  }
}
