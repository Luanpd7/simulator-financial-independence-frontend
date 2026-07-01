import 'package:intl/intl.dart';

class SimulationResult {
  final double finalAmount;
  final double inflationAdjustedAmount;
  final double realRateYear;
  final double realRateMonth;
  final double totalContributed;
  final double totalInterestEarned;
  final int yearsToRetirement;

  const SimulationResult({
    required this.finalAmount,
    required this.inflationAdjustedAmount,
    required this.realRateYear,
    required this.realRateMonth,
    required this.totalContributed,
    required this.totalInterestEarned,
    required this.yearsToRetirement,
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
    );
  }




Map<String, String> toDisplayMap() {

  final currency= NumberFormat.simpleCurrency(locale: 'pt_BR');


  final percent = NumberFormat.decimalPercentPattern(locale: 'pt_BR', decimalDigits: 2);

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
