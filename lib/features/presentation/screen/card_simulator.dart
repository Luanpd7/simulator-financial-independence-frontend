
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:simulator/features/domain/entities/financial_independence.dart';
import '../../domain/entities/simulation_result.dart';
import '../../domain/usecases/CalculateSimulationUseCase.dart';
import '../chart/financialEvolutionChart.dart';
import '../utils/default_text_form.dart';
import '../utils/input_formatters.dart';


class SimulatorState with ChangeNotifier {
  final CalculateSimulationUseCase _calculateSimulationUseCase;

  SimulatorState(this._calculateSimulationUseCase);

  SimulationResult? _resultSimulation;
  bool isLoading = false;
  bool _isTimeInYears = false;

  final TextEditingController currentsAssentController =
      TextEditingController();
  final TextEditingController monthlyContributionController =
      TextEditingController();
  final TextEditingController annualPercentageController =
      TextEditingController();
  final TextEditingController currentAgeController = TextEditingController();
  final TextEditingController retirementAgeController = TextEditingController();
  final TextEditingController timeInYearsController = TextEditingController();
  final TextEditingController inflationController = TextEditingController();

  bool get isTimeInYears => _isTimeInYears;

  bool get isAfterCalculation => resultSimulation != null;

  SimulationResult? get resultSimulation => _resultSimulation;

  List<_Content>? get list {
    return resultSimulation?.toDisplayMap().entries.map((e) {
      return _Content(title: e.key, value: e.value);
    }).toList();
  }

  set isTimeInYears(bool value) {
    _isTimeInYears = value;
    notifyListeners();
  }

  set resultSimulation(SimulationResult? value) {
    _resultSimulation = value;
    notifyListeners();
  }

  Future<void> callSimulator() async {
    isLoading = true;
    notifyListeners();

    try {
      var simulation = FinancialIndependence(
        currentAssets: double.parse(
          currentsAssentController.text
              .replaceAll('R\$ ', '')
              .replaceAll('.', '')
              .replaceAll(',', '.')
              .trim(),
        ),
        monthlyContribution: double.parse(
          monthlyContributionController.text
              .replaceAll('R\$ ', '')
              .replaceAll('.', '')
              .replaceAll(',', '.')
              .trim(),
        ),
        annualPercentage: double.parse(
          annualPercentageController.text
              .replaceAll('.', '')
              .replaceAll(',', '.')
              .trim(),
        ),
        currentAge: !_isTimeInYears
            ? int.parse(currentAgeController.text)
            : null,
        retirementAge: !_isTimeInYears
            ? int.parse(retirementAgeController.text)
            : null,
        timeInYears: _isTimeInYears
            ? int.tryParse(timeInYearsController.text)
            : null,
        inflation: double.parse(
          inflationController.text
              .replaceAll('.', '')
              .replaceAll(',', '.')
              .trim(),
        ),
      );

      resultSimulation = await _calculateSimulationUseCase.call(simulation);

    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool validation() {
    var validationFieldsTimer = _isTimeInYears
        ? timeInYearsController.text.isNotEmpty
        : currentAgeController.text.isNotEmpty &&
              retirementAgeController.text.isNotEmpty;

    var validationAnotherFields =
        currentsAssentController.text.isNotEmpty &&
        monthlyContributionController.text.isNotEmpty &&
        annualPercentageController.text.isNotEmpty &&
        inflationController.text.isNotEmpty;

    return validationFieldsTimer && validationAnotherFields;
  }

  void cleanField() {
    currentsAssentController.clear();
    monthlyContributionController.clear();
    annualPercentageController.clear();
    retirementAgeController.clear();
    timeInYearsController.clear();
    inflationController.clear();
    currentAgeController.clear();
    resultSimulation = null;
  }
}

class _Content {
  _Content({required this.title, required this.value});
  final String title;
  final dynamic value;
}

class ScreenFinancesIndependence extends StatelessWidget {
  const ScreenFinancesIndependence({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          SimulatorState(context.read<CalculateSimulationUseCase>()),
      child: Consumer<SimulatorState>(
        builder: (context, state, _) {
          return Column(
            spacing: 20,
            children: [
              _CardSimulator(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                reverseDuration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutQuart,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
                child: state.isAfterCalculation
                    ? _CardResult(key: const ValueKey('result_card'))
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CardSimulator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SimulatorState>(
      builder: (context, state, _) {
        return Container(
          width: 750,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),

                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Simulador financeiro',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Tooltip(
                      message:
                          'Aqui você pode simular a independencia financeira para a sua aposentadoria',
                      child: Icon(Icons.info, color: Colors.grey.shade200),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: DefaultInput(
                            label: "Patrimonio",
                            controller: state.currentsAssentController,
                            icon: Icons.monetization_on,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DefaultInput(
                            label: "Aporte mensal",
                            controller: state.monthlyContributionController,
                            icon: Icons.real_estate_agent,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: DefaultInput(
                            label: "Inflação",
                            controller: state.inflationController,
                            icon: Icons.show_chart,

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              PercentageInputFormatter(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DefaultInput(
                            label: "Juros anual",
                            controller: state.annualPercentageController,
                            icon: Icons.percent,

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              PercentageInputFormatter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        if (!state.isTimeInYears) ...[
                          Expanded(
                            child: DefaultInput(
                              label: "Idade atual",
                              controller: state.currentAgeController,
                              icon: Icons.person,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          Expanded(
                            child: DefaultInput(
                              label: "idade para aposentar",
                              controller: state.retirementAgeController,
                              icon: Icons.elderly,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ] else
                          Expanded(
                            child: DefaultInput(
                              label: "Tempo em anos",
                              controller: state.timeInYearsController,
                              icon: Icons.timer,
                              inputFormatters: [],
                            ),
                          ),
                        _MenuTimer(),
                      ],
                    ),
                    _ButtonCalculationAndClean(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ButtonCalculationAndClean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SimulatorState>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 22,
            top: 4,
            left: 12,
            right: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    state.isAfterCalculation
                        ? Colors.white38
                        : Colors.blue.shade700,
                  ),
                ),
                onPressed: () {
                  if (!state.isAfterCalculation) {
                    if (!state.validation()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Você deve preencher todos os campos'),
                        ),
                      );
                      return;
                    }
                    state.callSimulator();
                  }
                },
                child: Text('Calcular', style: TextStyle(color: Colors.white)),
              ),
              GestureDetector(
                onTap: () => state.cleanField(),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text('Limpar', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuTimer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SimulatorState>(
      builder: (context, state, _) {
        return DropdownMenu(
          initialSelection: state.isTimeInYears,
          label: Text('Selecionar tempo'),

          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            maximumSize: MaterialStatePropertyAll<Size>(Size.infinite),
            visualDensity: VisualDensity.standard,
          ),
          textStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
          dropdownMenuEntries: [
            DropdownMenuEntry(value: false, label: 'Idade'),
            DropdownMenuEntry(value: true, label: 'Tempo'),
          ],
          onSelected: (value) {
            state.isTimeInYears = (value ?? false);
          },
        );
      },
    );
  }
}

class _CardResult extends StatelessWidget {
  const _CardResult({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<SimulatorState>(context);

    return Container(
      width: 750,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsetsGeometry.symmetric(horizontal: 22, vertical: 18),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resultado da simulação',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Tooltip(
                  message:
                      'Aqui você pode simular a independencia financeira para a sua aposentadoria',
                  child: Icon(Icons.info, color: Colors.grey.shade200),
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              ...state.list?.map(
                    (e) => SizedBox(
                      width: 350,
                      child: _InfoResult(title: e.title, value: e.value),
                    ),
                  ) ??
                  [],
            ],
          ),
          FinancialEvolutionChart(
            evolutions: state.resultSimulation?.evolutions ?? [],
          ),
        ],
      ),
    );
  }
}

class _InfoResult extends StatelessWidget {
  const _InfoResult({required this.title, required this.value});

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Consumer<SimulatorState>(
      builder: (context, state, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade300,
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  value.toString(),
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
