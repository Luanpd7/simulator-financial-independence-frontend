import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/financial_independence.dart';
import '../../domain/entities/simulation_result.dart';
import '../../domain/repositories/SimulationRepository.dart';


class SimulationRepositoryImpl implements SimulationRepository {
  @override
  Future<SimulationResult> calculate(
      FinancialIndependence simulation,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/simulation'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(simulation.toJson()),
      );



      if (response.statusCode != 200) {
        throw Exception('Erro na requisição');
      }

      final data = jsonDecode(response.body);
      print('Status: ${response.statusCode}');
      print('data: ${data}');
      return SimulationResult.fromJson(data);
    } catch (e) {
      throw Exception(
        'Erro ao calcular a independência financeira: $e',
      );
    }
  }
}