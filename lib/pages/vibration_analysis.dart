import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/BarGraph.dart';
import '../components/MultiLineGraph.dart';

class VibrationAnalysis extends StatefulWidget {
  const VibrationAnalysis({super.key});

  @override
  State<VibrationAnalysis> createState() => _VibrationAnalysisState();
}

class _VibrationAnalysisState extends State<VibrationAnalysis> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 2; i++)
            Column(
              children: [
                // const SizedBox(height: 20),
                const Text(
                  'Spindle Front Bearing',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(top: 50),
                  padding: EdgeInsets.all(10),
                  width: width * 0.45,
                  height: height * 0.4,
                  // color: const Color.fromARGB(255, 255, 255, 255),
                  child: const SizedBox(
                    // height: 300,
                    child: BarGraph(),
                  ),
                ),
                Container(
                  width: width * 0.50,
                  height: height * 0.4,
                  // color: const Color.fromARGB(255, 255, 255, 255),
                  child: const SizedBox(
                    height: 300,
                    child: MultiLineGraph(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
