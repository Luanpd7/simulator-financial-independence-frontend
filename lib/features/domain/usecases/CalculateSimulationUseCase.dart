import '../entities/financial_independence.dart';
import '../entities/simulation_result.dart';
import '../repositories/SimulationRepository.dart';

class CalculateSimulationUseCase {
  final SimulationRepository repository;

  CalculateSimulationUseCase(this.repository);

  Future<SimulationResult> call(
      FinancialIndependence simulation,
      ) async {
    return repository.calculate(simulation);
  }
}