import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulator/features/domain/entities/evolution_assets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class FinancialEvolutionChart extends StatelessWidget {
  FinancialEvolutionChart({super.key, required this.evolutions});

  final List<EvolutionAssets> evolutions;
  @override
  Widget build(BuildContext context) {
    final maxValue = evolutions
        .map((e) => math.max(e.finalAssets, e.finalAssetsAdjusted))
        .reduce(math.max);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: 400,
        width: 750,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Evolução do Patrimônio',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: LineChart(
                  LineChartData(
                    maxX: evolutions.isNotEmpty
                        ? evolutions.last.year.toDouble()
                        : 1,
                    maxY: maxValue * 1.1,

                    gridData: FlGridData(show: true, drawVerticalLine: false),

                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade400),
                        bottom: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),

                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text("Anos"),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: maxValue / 5,
                          reservedSize: 80,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              NumberFormat.compactCurrency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                              ).format(value),
                            );
                          },
                        ),
                      ),
                    ),

                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2).format(spot.y)}',
                              TextStyle(
                                color: spot.barIndex == 0
                                    ? Colors.blue
                                    : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                        tooltipBorderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),

                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        dotData: const FlDotData(show: true),
                        spots: evolutions
                            .map(
                              (e) => FlSpot(e.year.toDouble(), e.finalAssets),
                        )
                            .toList(),
                      ),

                      LineChartBarData(
                        isCurved: true,
                        color: Colors.orange,
                        barWidth: 4,
                        dotData: const FlDotData(show: true),
                        spots: evolutions
                            .map(
                              (e) => FlSpot(
                            e.year.toDouble(),
                            e.finalAssetsAdjusted,
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 24,
                children: const [
                  _Legend(color: Colors.blue, title: 'Patrimônio'),
                  _Legend(
                    color: Colors.orange,
                    title: 'Corrigido pela inflação',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String title;

  const _Legend({required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}