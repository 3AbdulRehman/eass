import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalStudents = 100; // Example value
    double absentStudents = 30; // Example value

    return CircularChart(
      totalStudentCount: totalStudents,
      absentStudentCount: absentStudents,
    );
  }
}

class CircularChart extends StatelessWidget {
  final double totalStudentCount;
  final double absentStudentCount;

  CircularChart({required this.totalStudentCount, required this.absentStudentCount});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Students',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  totalStudentCount.toString(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.red,
                          value: absentStudentCount,
                          title: '$absentStudentCount',
                          radius: 50,
                        ),
                        PieChartSectionData(
                          color: Colors.transparent,
                          value: totalStudentCount - absentStudentCount,
                          title: '',
                          radius: 60,
                        ),
                      ],
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Absent Students',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
