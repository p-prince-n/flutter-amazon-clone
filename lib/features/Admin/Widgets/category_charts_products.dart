// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:amazon/features/Admin/model/sales.dart';

class CategoryChartsProducts extends StatelessWidget {
  final String totalAmount;
  final List<Sales> sales;
  const CategoryChartsProducts({
    Key? key,
    required this.totalAmount,
    required this.sales,
  }) : super(key: key);

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(
      sales.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: double.parse(sales[index].eraning.toString()),
            color: Colors.blue,
            width: 25,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            maxY: double.parse(totalAmount) < 1000
                ? 1000
                : double.parse(totalAmount) < 2500
                    ? 2500
                    : double.parse(totalAmount) < 5000
                        ? 5000
                        : double.parse(totalAmount),
            barGroups: _getBarGroups(),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      '\$${value.toInt().toString()}',
                      style: TextStyle(
                          fontSize: 8), // Smaller font size to avoid overlap
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(sales[value.toInt()].label,
                        style: TextStyle(fontSize: 10));
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
          ),
        ),
      ),
    );
  }
}
