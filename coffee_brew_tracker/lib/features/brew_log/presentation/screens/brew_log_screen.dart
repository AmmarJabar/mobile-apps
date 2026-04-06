import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_brew_tracker/core/constants/app_constants.dart';
import 'package:coffee_brew_tracker/core/utils/ratio_calculator.dart';
import 'package:coffee_brew_tracker/core/widgets/labeled_slider.dart';
import 'package:coffee_brew_tracker/core/widgets/rating_stars.dart';
import 'package:coffee_brew_tracker/core/widgets/section_header.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/features/brew_log/presentation/controllers/brew_log_controller.dart';
import 'package:coffee_brew_tracker/features/history/presentation/controllers/history_controller.dart';

class BrewLogScreen extends ConsumerStatefulWidget {
  const BrewLogScreen({super.key});

  @override
  ConsumerState<BrewLogScreen> createState() => _BrewLogScreenState();
}

class _BrewLogScreenState extends ConsumerState<BrewLogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Shared fields
  final _coffeeNameController = TextEditingController();
  final _originController = TextEditingController();
  final _roasterController = TextEditingController();
  String? _selectedProcess;
  String? _selectedRoastLevel;
  final _grindSizeController = TextEditingController();
  double _temperature = 93.0;
  int _rating = 3;
  final _notesController = TextEditingController();
  List<String> _coffeeNameSuggestions = [];
  List<String> _originSuggestions = [];
  List<String> _roasterSuggestions = [];

  // Pour Over fields
  String? _selectedMethod = AppConstants.pourOverMethods.first;
  final _coffeeWeightController = TextEditingController(text: "15");
  final _waterWeightController = TextEditingController(text: "250");
  final _brewTimeController = TextEditingController(); // in seconds
  final _recipeController = TextEditingController();

  // Espresso fields
  final _doseController = TextEditingController(text: "18");
  final _yieldController = TextEditingController(text: "36");
  final _extractionTimeController = TextEditingController(text: "30");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final notifier = ref.read(historyControllerProvider.notifier);
    final results = await Future.wait([
      notifier.getDistinctCoffeeNames(),
      notifier.getDistinctOrigins(),
      notifier.getDistinctRoasters(),
    ]);
    
    if (mounted) {
      setState(() {
        _coffeeNameSuggestions = results[0];
        _originSuggestions = results[1];
        _roasterSuggestions = results[2];
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _coffeeNameController.dispose();
    _grindSizeController.dispose();
    _originController.dispose();
    _roasterController.dispose();
    _notesController.dispose();
    _coffeeWeightController.dispose();
    _waterWeightController.dispose();
    _brewTimeController.dispose();
    _recipeController.dispose();
    _doseController.dispose();
    _yieldController.dispose();
    _extractionTimeController.dispose();
    super.dispose();
  }

  void _saveBrew() {
    if (!_formKey.currentState!.validate()) return;

    final isPourOver = _tabController.index == 0;
    
    // Parse shared numeric values
    final brewTimeMins = double.tryParse(_brewTimeController.text) ?? 0.0;
    final parsedPoTime = (brewTimeMins * 60).round();

    final coffeeWtPo = double.tryParse(_coffeeWeightController.text) ?? 0.0;
    final waterWtPo = double.tryParse(_waterWeightController.text) ?? 0.0;
    final ratioPo = RatioCalculator.pourOver(coffeeWtPo, waterWtPo);

    final doseEsp = double.tryParse(_doseController.text) ?? 0.0;
    final yieldEsp = double.tryParse(_yieldController.text) ?? 0.0;
    final extractTimeEsp = int.tryParse(_extractionTimeController.text) ?? 0;
    final ratioEsp = RatioCalculator.espresso(doseEsp, yieldEsp);

    final grindSizeVal = double.tryParse(_grindSizeController.text) ?? 0.0;

    final brew = BrewEntity(
      brewType: isPourOver ? 'pour_over' : 'espresso',
      coffeeName: _coffeeNameController.text,
      origin: _originController.text.isEmpty ? null : _originController.text,
      roaster: _roasterController.text.isEmpty ? null : _roasterController.text,
      process: _selectedProcess,
      roastLevel: _selectedRoastLevel,
      grindSize: grindSizeVal,
      temperature: _temperature,
      coffeeWeight: isPourOver ? coffeeWtPo : doseEsp,
      waterWeight: isPourOver ? waterWtPo : null,
      brewTime: isPourOver ? parsedPoTime : extractTimeEsp,
      ratio: isPourOver ? ratioPo : ratioEsp,
      rating: _rating,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      // Pour Over specifics
      brewMethod: isPourOver ? _selectedMethod : null,
      recipe: isPourOver && _recipeController.text.isNotEmpty ? _recipeController.text : null,
      // Espresso specifics
      dose: isPourOver ? null : doseEsp,
      brewYield: isPourOver ? null : yieldEsp,
      extractionTime: isPourOver ? null : extractTimeEsp,
    );

    if (isPourOver) {
      ref.read(brewLogControllerProvider.notifier).savePourOver(brew);
    } else {
      ref.read(brewLogControllerProvider.notifier).saveEspresso(brew);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(brewLogControllerProvider, (previous, next) {
      if (next == BrewLogState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Brew saved successfully!')),
        );
        context.go('/');
      } else if (next == BrewLogState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save brew.')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Brew'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: 'Pour Over'),
            Tab(text: 'Espresso'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildLogForm(context, isPourOver: true),
            _buildLogForm(context, isPourOver: false),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              final state = ref.read(brewLogControllerProvider);
              if (state != BrewLogState.loading) {
                _saveBrew();
              }
            },
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(brewLogControllerProvider);
                if (state == BrewLogState.loading) {
                  return const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  );
                }
                return const Text('Save Brew');
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogForm(BuildContext context, {required bool isPourOver}) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // ── Coffee Details ──
        const SectionHeader(title: 'Coffee'),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return _coffeeNameSuggestions.where((String option) {
              return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            _coffeeNameController.text = selection;
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            // Synchronize internal controller with shared controller
            if (controller.text != _coffeeNameController.text) {
              controller.text = _coffeeNameController.text;
            }
            
            // This is a bit of a hack to sync changes back to the shared controller
            // since Autocomplete manages its own internal controller.
            controller.addListener(() {
              if (_coffeeNameController.text != controller.text) {
                _coffeeNameController.text = controller.text;
              }
            });

            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Coffee Name *',
                hintText: 'e.g. Ethiopia Yirgacheffe',
              ),
              onFieldSubmitted: (value) => onFieldSubmitted(),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _originSuggestions.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _originController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  if (controller.text != _originController.text) {
                    controller.text = _originController.text;
                  }
                  controller.addListener(() {
                    if (_originController.text != controller.text) {
                      _originController.text = controller.text;
                    }
                  });
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(labelText: 'Origin'),
                    onFieldSubmitted: (value) => onFieldSubmitted(),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _roasterSuggestions.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _roasterController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  if (controller.text != _roasterController.text) {
                    controller.text = _roasterController.text;
                  }
                  controller.addListener(() {
                    if (_roasterController.text != controller.text) {
                      _roasterController.text = controller.text;
                    }
                  });
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(labelText: 'Roaster'),
                    onFieldSubmitted: (value) => onFieldSubmitted(),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Process'),
                value: _selectedProcess,
                items: AppConstants.processes
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedProcess = val),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Roast Level'),
                value: _selectedRoastLevel,
                items: AppConstants.roastLevels
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRoastLevel = val),
              ),
            ),
          ],
        ),

        // ── Grind & Temp ──
        const SectionHeader(title: 'Settings'),
        TextFormField(
          controller: _grindSizeController,
          decoration: const InputDecoration(labelText: 'Grind Size *'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 12),
        LabeledSlider(
          label: 'Temperature',
          value: _temperature,
          min: AppConstants.minTemperature,
          max: AppConstants.maxTemperature,
          unit: '°C',
          divisions: (AppConstants.maxTemperature - AppConstants.minTemperature).toInt(),
          decimalDigits: 0,
          onChanged: (val) => setState(() => _temperature = val),
        ),

        // ── Method Specifics ──
        if (isPourOver) ...[
          const SectionHeader(title: 'Pour Over Recipe'),
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Brew Method'),
            value: _selectedMethod,
            items: AppConstants.pourOverMethods
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            onChanged: (val) => setState(() => _selectedMethod = val),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _coffeeWeightController,
                  decoration: const InputDecoration(labelText: 'Coffee (g) *', suffixText: 'g'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _waterWeightController,
                  decoration: const InputDecoration(labelText: 'Water (g) *', suffixText: 'g'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _brewTimeController,
            decoration: const InputDecoration(labelText: 'Brew Time (min) *', suffixText: 'min'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _recipeController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Recipe Steps',
              hintText: 'e.g. Bloom 30g 45s, pour to 150g...',
            ),
          ),
        ] else ...[
          const SectionHeader(title: 'Espresso Recipe'),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _doseController,
                  decoration: const InputDecoration(labelText: 'Dose (g) *', suffixText: 'g'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _yieldController,
                  decoration: const InputDecoration(labelText: 'Yield (g) *', suffixText: 'g'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _extractionTimeController,
            decoration: const InputDecoration(labelText: 'Extraction Time (sec) *', suffixText: 's'),
            keyboardType: TextInputType.number,
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
        ],

        // ── Result & Notes ──
        const SectionHeader(title: 'Result'),
        Center(
          child: Column(
            children: [
              RatingStars(
                rating: _rating,
                onChanged: (val) => setState(() => _rating = val),
              ),
              const SizedBox(height: 8),
              Text(
                _rating == 5 ? 'Perfect' : _rating >= 4 ? 'Good' : _rating >= 3 ? 'Okay' : 'Needs Work',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Tasting Notes',
            hintText: 'e.g. Bright acidity, dark chocolate finish',
          ),
        ),
        const SizedBox(height: 32), // Padding for nav bar
      ],
    );
  }
}
