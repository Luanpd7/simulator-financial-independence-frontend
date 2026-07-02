class FinancialIndependence {
  final double currentAssets;
  final double monthlyContribution;
  final double annualPercentage;
  final int? currentAge;
  final int? retirementAge;
  final int? timeInYears;
  final double inflation;

  const FinancialIndependence({
    required this.currentAssets,
    required this.monthlyContribution,
    required this.annualPercentage,
    required this.currentAge,
    required this.retirementAge,
    required this.timeInYears,
    required this.inflation,
  });

  Map<String, dynamic> toJson() {
    return {
      'currentAssets': currentAssets,
      'monthlyContribution': monthlyContribution,
      'annualPercentage': annualPercentage,
      'currentAge': currentAge,
      'retirementAge': retirementAge,
      'timeInYears': timeInYears,
      'inflation': inflation,
    };
  }
}
