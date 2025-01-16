import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import "dart:math";
import 'package:model_viewer_plus/model_viewer_plus.dart';

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
  late Future<String> _modelPath;
  // String threedmodelpath = '/assets/images/cmti-logo.png';
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

    _modelPath = threedmodelpath();
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
        backgroundColor: Colors.black87,
        body: Padding(
          padding: EdgeInsets.only(top: height * 0.05),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: height * 0.40,
                      width: width * 0.55,
                      child: ModelViewer(
                        interactionPrompt: InteractionPrompt.none,
                        cameraOrbit: "0deg 100deg 70%",
                        backgroundColor: Color.fromARGB(144, 36, 36, 36),
                        src:
                            "https://firebasestorage.googleapis.com/v0/b/dos1-23caf.appspot.com/o/Spindle.gltf?alt=media&token=ac3e2e4b-c7c2-4138-8153-740857562a07",
                        alt: 'A 3D model of an astronaut',
                        ar: true,
                        autoRotate: true,
                        disableZoom: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.03,
                          width * 0.05, height * 0.03),
                      child: SizedBox(
                        width: width * 0.6,
                        child: Text(
                          'iPreciSpindle_18K  is a cutting-edge solution for integrated motor high speed SMART spindle. The system is designed and developed in collaboration with M/s Acumac, typically provide high frequency, high precision and accuracy for machine tool application. The developed i precispindle offers real time condition monitoring module enables Data analytics & adoptive control through SMART enabled IIoT board with GUI.',
                          style: TextStyle(
                            color: Colors.white, // Set text color to white
                            fontSize: 20, // Adjust font size as needed
                          ),
                          softWrap: true, // Allow text to wrap to the next line
                          overflow:
                              TextOverflow.visible, // Make overflow visible
                          textAlign: TextAlign
                              .justify, // Align text for better readability
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      height: height * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title
                            Text(
                              "Salient Features",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    16), // Spacing between title and features
                            // Two-column features
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left column
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SalientFeatureItem(
                                        text:
                                            "Design assisted for high frequency",
                                        picture_index: 1,
                                      ),
                                      SalientFeatureItem(
                                          text:
                                              "Additional micro balancing system",
                                          picture_index: 2),
                                      SalientFeatureItem(
                                          text:
                                              "Inbuilt sensors for data acquisition",
                                          picture_index: 3),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        width * 0.1), // Spacing between columns
                                // Right column
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SalientFeatureItem(
                                        text:
                                            "Real-time data condition monitoring",
                                        picture_index: 4,
                                      ),
                                      SalientFeatureItem(
                                        text:
                                            "Data analytics & adaptive control",
                                        picture_index: 5,
                                      ),
                                      SalientFeatureItem(
                                        text: "IIoT enabled, Dashboard (GUI)",
                                        picture_index: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                const TableWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> threedmodelpath() async {
    // Get reference to the file
    Reference ref = FirebaseStorage.instance.ref('Spindle.gltf');

// Fetch the download URL
    String url = await ref.getDownloadURL();
    print(url);
    return url;
  }
}

class SalientFeatureItem extends StatelessWidget {
  final String text;
  final int picture_index;

  const SalientFeatureItem({required this.text, required this.picture_index});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(bottom: height * 0.02), // Spacing between items
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(83, 46, 74, 235), // Background color for the container
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Soft shadow
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        padding: EdgeInsets.all(10), // Padding inside the container
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.05,
              width: width * 0.1,
              child: Image.asset(
                'assets/images/feature-${picture_index}.png',
                fit: BoxFit.fitHeight, // Ensure the image fits well
              ),
            ),
            SizedBox(width: width * 0.005), // Spacing between image and text
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  
                  color: Colors.white, // Text color
                  fontSize: 20, // Font size for readability
                  fontWeight: FontWeight.w500, // Slightly bold
                  fontFamily: 'Roboto', // Use a modern font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<String> Parameters = [
    "Spindle Type",
    "Spindle Runout Accuracy",
    "Maximum Speed",
    "Rated Speed",
    "Rated Torque",
    "Power",
    "Rated Current",
    "Bearing Type",
    "Bearing Arrangement",
    "Lubrication Type",
    "Lubrication Oil Displacement",
    "Tool Interface",
    "Drawbar Actuation Type",
    "Encoder Type",
    "Spindle Balancing Grade"
  ];
  List<String> Specification = [
    "Integrated Motor (Synchronous) Spindle",
    '<2 µm',
    "20000 rpm",
    "18000 rpm",
    "42 Nm @ 3500 rpm",
    "15.5 kW",
    "42 A",
    "Super Precision Angular Contact Bearings",
    "Back to Back",
    "Oil Air Mist",
    "0.03 ml per Stroke",
    "HSK A 63",
    "Hydraulic",
    "Magnetic Incremental Encoder",
    "G1"
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double cell_height = height * 0.05;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Column(
        //   children: [
        //     Cell('SL NO', width * 0.03, cell_height, true, true),
        //     for (int i = 1; i < Parameters.length + 1; i++)
        //       Cell('$i', width * 0.03, cell_height, false, true)
        //   ],
        // ),
        Column(
          children: [
            Cell('Parameter', width * 0.12, cell_height, true, false),
            for (int i = 0; i < Parameters.length; i++)
              Cell('${Parameters[i]}', width * 0.12, cell_height, false, false)
          ],
        ),
        Column(
          children: [
            Cell('Specification', width * 0.12, cell_height, true, false),
            for (int i = 0; i < Parameters.length; i++)
              Cell('${Specification[i]}', width * 0.12, cell_height, false,
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
          SizedBox(
            width: width * 0.03,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: FirstColumnCheck ? Colors.white : Colors.black,
                fontSize: width * 0.07,
              ),

              softWrap: true, // Allow text to wrap
              overflow: TextOverflow.visible, // Avoid overflow by clipping
              textAlign: CenterOrStartCheck
                  ? TextAlign.center
                  : TextAlign.start, // Align text dynamically
            ),
          ),
        ],
      ),
    );
  }
}
