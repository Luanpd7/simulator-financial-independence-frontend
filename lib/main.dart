import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simulator/features/presentation/screen/card_simulator.dart';

import 'features/data/repositories/simulation_repository_impl.dart';
import 'features/domain/repositories/SimulationRepository.dart';
import 'features/domain/usecases/CalculateSimulationUseCase.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<SimulationRepository>(
          create: (_) => SimulationRepositoryImpl(),
        ),
        Provider<CalculateSimulationUseCase>(
          create: (context) =>
              CalculateSimulationUseCase(context.read<SimulationRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade700,
            title: const Text(
              'Simulador Financeiro',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/imagem_fundo.png"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                opacity: 0.5,
              ),
            ),
            child: const Center(
              child: SingleChildScrollView(child: ScreenFinancesIndependence()),
            ),
          ),
        ),
      ),
    ),
  );
}
