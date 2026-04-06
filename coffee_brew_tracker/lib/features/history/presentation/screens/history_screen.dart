import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_brew_tracker/features/history/presentation/controllers/history_controller.dart';
import 'package:coffee_brew_tracker/core/constants/app_constants.dart';
import 'package:coffee_brew_tracker/features/history/presentation/widgets/brew_list_item.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String? _filterType;
  int? _filterMinRating;
  String? _filterProcess;
  String? _filterRoast;
  String? _filterOrigin;

  void _applyFilters() {
    ref.read(historyControllerProvider.notifier).loadBrews(
      brewType: _filterType,
      minRating: _filterMinRating,
      process: _filterProcess,
      roastLevel: _filterRoast,
      origin: _filterOrigin,
    );
  }

  void _clearAllFilters() {
    setState(() {
      _filterType = null;
      _filterMinRating = null;
      _filterProcess = null;
      _filterRoast = null;
      _filterOrigin = null;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyControllerProvider);

    final bool hasFilters = _filterType != null || _filterMinRating != null || _filterProcess != null || _filterRoast != null || _filterOrigin != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brew History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: _clearAllFilters,
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text('Clear All'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_filterType != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(_filterType == AppConstants.pourOver ? 'Pour Over' : 'Espresso'),
                          onDeleted: () {
                            setState(() => _filterType = null);
                            _applyFilters();
                          },
                        ),
                      ),
                    if (_filterMinRating != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text('$_filterMinRating+ Stars'),
                          onDeleted: () {
                            setState(() => _filterMinRating = null);
                            _applyFilters();
                          },
                        ),
                      ),
                    if (_filterProcess != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(_filterProcess!),
                          onDeleted: () {
                            setState(() => _filterProcess = null);
                            _applyFilters();
                          },
                        ),
                      ),
                    if (_filterRoast != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(_filterRoast!),
                          onDeleted: () {
                            setState(() => _filterRoast = null);
                            _applyFilters();
                          },
                        ),
                      ),
                    if (_filterOrigin != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(_filterOrigin!),
                          onDeleted: () {
                            setState(() => _filterOrigin = null);
                            _applyFilters();
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.brews.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.coffee_rounded, size: 64, color: Theme.of(context).colorScheme.surfaceVariant),
                            const SizedBox(height: 16),
                            Text('No brews found', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            Text('Tap + to log your first brew', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.brews.length,
                        itemBuilder: (context, index) {
                          final brew = state.brews[index];
                          return BrewListItem(
                            brew: brew,
                            onDelete: () {
                              ref.read(historyControllerProvider.notifier).deleteBrew(brew.id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Brew deleted')),
                              );
                            },
                            onTap: () {
                              context.push('/brew-detail', extra: brew);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) async {
    final origins = await ref.read(historyControllerProvider.notifier).getDistinctOrigins();
    
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (_, controller) {
              return ListView(
                controller: controller,
                children: [
                  ListTile(
                    title: const Text('Reset All Filters', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    onTap: () {
                      _clearAllFilters();
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Pour Over Only'),
                    onTap: () {
                      setState(() => _filterType = AppConstants.pourOver);
                      _applyFilters();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Espresso Only'),
                    onTap: () {
                      setState(() => _filterType = AppConstants.espresso);
                      _applyFilters();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('4+ Stars Only'),
                    onTap: () {
                      setState(() => _filterMinRating = 4);
                      _applyFilters();
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ExpansionTile(
                    title: const Text('Filter by Process'),
                    children: AppConstants.processes.map((process) => ListTile(
                      title: Text(process),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                      onTap: () {
                        setState(() => _filterProcess = process);
                        _applyFilters();
                        Navigator.pop(context);
                      },
                    )).toList(),
                  ),
                  ExpansionTile(
                    title: const Text('Filter by Roast Level'),
                    children: AppConstants.roastLevels.map((roast) => ListTile(
                      title: Text(roast),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                      onTap: () {
                        setState(() => _filterRoast = roast);
                        _applyFilters();
                        Navigator.pop(context);
                      },
                    )).toList(),
                  ),
                  if (origins.isNotEmpty)
                    ExpansionTile(
                      title: const Text('Filter by Origin'),
                      children: origins.map((origin) => ListTile(
                        title: Text(origin),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                        onTap: () {
                          setState(() => _filterOrigin = origin);
                          _applyFilters();
                          Navigator.pop(context);
                        },
                      )).toList(),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
