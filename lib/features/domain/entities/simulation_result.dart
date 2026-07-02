import 'package:intl/intl.dart';

import 'evolution_assets.dart';

class SimulationResult {
  final double finalAmount;
  final double inflationAdjustedAmount;
  final double realRateYear;
  final double realRateMonth;
  final double totalContributed;
  final double totalInterestEarned;
  final int yearsToRetirement;
  final List<EvolutionAssets> evolutions;

  const SimulationResult({
    required this.finalAmount,
    required this.inflationAdjustedAmount,
    required this.realRateYear,
    required this.realRateMonth,
    required this.totalContributed,
    required this.totalInterestEarned,
    required this.yearsToRetirement,
    required this.evolutions,
  });

  factory SimulationResult.fromJson(Map<String, dynamic> json) {
    return SimulationResult(
      finalAmount: json['finalAmount'] ?? 0,
      inflationAdjustedAmount: json['inflationAdjustedAmount'] ?? 0,
      realRateYear: json['realRateYear'] ?? 0,
      realRateMonth: json['realRateMonth'] ?? 0,
      totalContributed: json['totalContributed'] ?? 0,
      totalInterestEarned: json['totalInterestEarned'] ?? 0,
      yearsToRetirement: json['yearsToRetirement'] ?? 0,
      evolutions: (json['evolutions'] as List<dynamic>?)
          ?.map((e) => EvolutionAssets.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }




Map<String, String> toDisplayMap() {

  final currency= NumberFormat.simpleCurrency(locale: 'pt_BR');

  return {
  'Patrimônio': currency.format(finalAmount),
  'Patrimônio ajustado pela inflação': currency.format(inflationAdjustedAmount),
  'Juros real/ano': '${realRateYear.toStringAsFixed(2).replaceAll('.', ',')}%',
  'Juros real/mês': '${realRateMonth.toStringAsFixed(4).replaceAll('.', ',')}%',
  'Total contribuído': currency.format(totalContributed),
  'Total rendido': currency.format(totalInterestEarned),
  'Anos até aposentadoria':'${ yearsToRetirement.toString()} anos',
  };
}
}
