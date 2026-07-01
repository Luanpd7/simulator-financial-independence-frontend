import '../entities/financial_independence.dart';
import '../entities/simulation_result.dart';

abstract class SimulationRepository {
  Future<SimulationResult> calculate(
      FinancialIndependence simulation,
      );
}