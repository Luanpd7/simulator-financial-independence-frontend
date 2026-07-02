class EvolutionAssets {
  EvolutionAssets({
    required this.year,
    required this.age,
    required this.finalAssets,
    required this.finalAssetsAdjusted,
  });

  final int year;
  final int age;
  final double finalAssets;
  final double finalAssetsAdjusted;

  factory EvolutionAssets.fromJson(Map<String, dynamic> json) {
    return EvolutionAssets(
      year: json['year'] as int,
      age: json['age'] as int,
      finalAssets: (json['finalAssets'] as num).toDouble(),
      finalAssetsAdjusted:
      (json['finalAssetsAdjusted'] as num).toDouble(),
    );
  }
}
