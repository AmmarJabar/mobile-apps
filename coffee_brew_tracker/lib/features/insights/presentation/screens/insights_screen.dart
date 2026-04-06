import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coffee_brew_tracker/features/insights/presentation/controllers/insights_controller.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  bool _filtersExpanded = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(insightsControllerProvider);
    final ctrl = ref.read(insightsControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
        actions: [
          if (state.hasActiveFilters)
            TextButton.icon(
              onPressed: () => ctrl.clearAllFilters(),
              icon: const Icon(Icons.filter_alt_off, size: 18),
              label: const Text('Clear'),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ctrl.loadInsights(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildFilterSection(context, state, ctrl),
                  ),
                  SliverToBoxAdapter(
                    child: _buildSummaryCards(context, state),
                  ),
                  if (state.brews.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _buildEmptyState(context, state),
                    )
                  else ...[
                    SliverToBoxAdapter(
                      child: _buildBrewTypeDistribution(context, state),
                    ),
                    SliverToBoxAdapter(
                      child: _buildTopRatedCoffees(context, state),
                    ),
                    SliverToBoxAdapter(
                      child: _buildRatingTrendSection(context, state),
                    ),
                    SliverToBoxAdapter(
                      child: _buildRatioScatterSection(context, state),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                ],
              ),
            ),
    );
  }

  // ── Filter Section ──────────────────────────────────────────────────────────

  Widget _buildFilterSection(
      BuildContext context, InsightsState state, InsightsController ctrl) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _filtersExpanded = !_filtersExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.tune, color: colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('Filters',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                  if (state.hasActiveFilters) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _activeFilterCount(state).toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Icon(
                    _filtersExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0, width: double.infinity),
            secondChild: _buildFilterBody(context, state, ctrl),
            crossFadeState: _filtersExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBody(
      BuildContext context, InsightsState state, InsightsController ctrl) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 10),

          // ── Brew Type ──────────────────────────────────────────────────────
          _filterLabel(context, 'Brew Type'),
          _buildChipRow(
            context,
            options: const [
              _ChipOption('Pour Over', 'pour_over'),
              _ChipOption('Espresso', 'espresso'),
            ],
            selected: state.filterBrewType,
            onTap: (val) => ctrl.setFilter(brewType: val),
          ),
          const SizedBox(height: 10),

          // ── Coffee ─────────────────────────────────────────────────────────
          if (state.availableCoffeeNames.isNotEmpty) ...[
            _filterLabel(context, 'Coffee'),
            _buildScrollableChipRow(
              context,
              options: state.availableCoffeeNames,
              selected: state.filterCoffeeName,
              onTap: (val) => ctrl.setFilter(coffeeName: val),
            ),
            const SizedBox(height: 10),
          ],

          // ── Origin ─────────────────────────────────────────────────────────
          if (state.availableOrigins.isNotEmpty) ...[
            _filterLabel(context, 'Origin'),
            _buildScrollableChipRow(
              context,
              options: state.availableOrigins,
              selected: state.filterOrigin,
              onTap: (val) => ctrl.setFilter(origin: val),
            ),
            const SizedBox(height: 10),
          ],

          // ── Process ────────────────────────────────────────────────────────
          if (state.availableProcesses.isNotEmpty) ...[
            _filterLabel(context, 'Process'),
            _buildScrollableChipRow(
              context,
              options: state.availableProcesses,
              selected: state.filterProcess,
              onTap: (val) => ctrl.setFilter(process: val),
            ),
            const SizedBox(height: 10),
          ],

          // ── Roast Level ────────────────────────────────────────────────────
          if (state.availableRoastLevels.isNotEmpty) ...[
            _filterLabel(context, 'Roast Level'),
            _buildScrollableChipRow(
              context,
              options: state.availableRoastLevels,
              selected: state.filterRoastLevel,
              onTap: (val) => ctrl.setFilter(roastLevel: val),
            ),
          ],
        ],
      ),
    );
  }

  Widget _filterLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }

  Widget _buildChipRow(
    BuildContext context, {
    required List<_ChipOption> options,
    required String? selected,
    required void Function(String?) onTap,
  }) {
    return Wrap(
      spacing: 8,
      children: options.map((opt) {
        final isSelected = selected == opt.value;
        return FilterChip(
          label: Text(opt.label),
          selected: isSelected,
          onSelected: (_) => onTap(isSelected ? null : opt.value),
          showCheckmark: false,
        );
      }).toList(),
    );
  }

  Widget _buildScrollableChipRow(
    BuildContext context, {
    required List<String> options,
    required String? selected,
    required void Function(String?) onTap,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((opt) {
          final isSelected = selected == opt;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (_) => onTap(isSelected ? null : opt),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  int _activeFilterCount(InsightsState state) {
    int count = 0;
    if (state.filterBrewType != null) count++;
    if (state.filterCoffeeName != null) count++;
    if (state.filterOrigin != null) count++;
    if (state.filterProcess != null) count++;
    if (state.filterRoastLevel != null) count++;
    return count;
  }

  // ── Summary Cards ───────────────────────────────────────────────────────────

  Widget _buildSummaryCards(BuildContext context, InsightsState state) {
    final isFiltered = state.hasActiveFilters;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFiltered)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.filter_alt,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 4),
                  Text(
                    'Showing ${state.filteredCount} of ${state.totalBrews} brews',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  context,
                  label: 'Total Brews',
                  value: state.totalBrews.toString(),
                  icon: Icons.coffee,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(
                  context,
                  label: isFiltered ? 'Filtered Avg' : 'Avg Rating',
                  value: state.averageRating.toStringAsFixed(1),
                  icon: Icons.star_rounded,
                  subtitle: '/ 5',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(
                  context,
                  label: 'This Week',
                  value: state.brewsThisWeek.toString(),
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(
                  context,
                  label: isFiltered ? 'Best Rating' : 'Best Rating',
                  value: state.bestRating > 0
                      ? state.bestRating.toStringAsFixed(0)
                      : '–',
                  icon: Icons.emoji_events_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    String? subtitle,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          children: [
            Icon(icon, color: colorScheme.primary, size: 22),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty State ─────────────────────────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context, InsightsState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.hasActiveFilters
                  ? Icons.search_off_rounded
                  : Icons.coffee_maker_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              state.hasActiveFilters
                  ? 'No brews match your filters'
                  : 'No brews logged yet',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              state.hasActiveFilters
                  ? 'Try removing some filters to see more data.'
                  : 'Log some brews to see insights here!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Brew Type Distribution ──────────────────────────────────────────────────

  Widget _buildBrewTypeDistribution(
      BuildContext context, InsightsState state) {
    final dist = state.brewTypeDistribution;
    if (dist.isEmpty) return const SizedBox.shrink();

    final total = dist.values.fold(0, (a, b) => a + b);
    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Brew Type Distribution',
      icon: Icons.pie_chart_rounded,
      child: Column(
        children: dist.entries.map((e) {
          final pct = total == 0 ? 0.0 : e.value / total;
          final label =
              e.key == 'pour_over' ? 'Pour Over' : _capitalize(e.key);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(label,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 10,
                      backgroundColor:
                          colorScheme.surfaceContainerHighest,
                      color: e.key == 'pour_over'
                          ? colorScheme.primary
                          : colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${e.value}  (${(pct * 100).toStringAsFixed(0)}%)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Top Rated Coffees ───────────────────────────────────────────────────────

  Widget _buildTopRatedCoffees(BuildContext context, InsightsState state) {
    final top = state.topRatedCoffees;
    if (top.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    const medals = ['🥇', '🥈', '🥉', '4️⃣', '5️⃣'];

    return _sectionCard(
      context,
      title: 'Top Rated Coffees',
      icon: Icons.emoji_events_rounded,
      child: Column(
        children: top.asMap().entries.map((entry) {
          final rank = entry.key;
          final name = entry.value.key;
          final avg = entry.value.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(rank < medals.length ? medals[rank] : '•',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _ratingStars(context, avg, colorScheme),
                const SizedBox(width: 6),
                Text(
                  avg.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _ratingStars(
      BuildContext context, double rating, ColorScheme colorScheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating.round() ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 14,
          color: colorScheme.tertiary,
        );
      }),
    );
  }

  // ── Rating Trend ────────────────────────────────────────────────────────────

  Widget _buildRatingTrendSection(BuildContext context, InsightsState state) {
    final recent = state.brews.take(10).toList().reversed.toList();
    if (recent.length < 2) {
      return _sectionCard(
        context,
        title: 'Rating Trend',
        icon: Icons.trending_up_rounded,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Need at least 2 brews to show trend.'),
        ),
      );
    }

    final spots = recent.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.rating.toDouble());
    }).toList();

    final colorScheme = Theme.of(context).colorScheme;

    return _sectionCard(
      context,
      title: 'Rating Trend (Last ${recent.length} Brews)',
      icon: Icons.trending_up_rounded,
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: colorScheme.primary,
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                    radius: 4,
                    color: colorScheme.primary,
                    strokeWidth: 2,
                    strokeColor: colorScheme.surface,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: colorScheme.primary.withOpacity(0.1),
                ),
              ),
            ],
            minY: 0,
            maxY: 5,
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (val, _) => Text(
                    val.toInt().toString(),
                    style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
              bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (val) => FlLine(
                color: colorScheme.outlineVariant.withOpacity(0.4),
                strokeWidth: 1,
              ),
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }

  // ── Ratio Scatter ───────────────────────────────────────────────────────────

  Widget _buildRatioScatterSection(BuildContext context, InsightsState state) {
    final filtered = state.filterBrewType == null
        ? state.brews.where((b) => b.brewType == 'pour_over').toList()
        : state.brews;

    // Only show scatter for pour over unless filtered explicitly
    if (state.filterBrewType == 'espresso') {
      return _buildEspressoStats(context, state);
    }

    if (filtered.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final spots = filtered.map((b) {
      return ScatterSpot(
        b.ratio,
        b.rating.toDouble(),
        dotPainter: FlDotCirclePainter(
          color: colorScheme.primary.withOpacity(0.8),
          radius: 5,
          strokeColor: colorScheme.surface,
          strokeWidth: 1.5,
        ),
      );
    }).toList();

    return _sectionCard(
      context,
      title: 'Ratio vs Rating (Pour Over)',
      icon: Icons.scatter_plot_rounded,
      child: SizedBox(
        height: 220,
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: spots,
            minX: 10,
            maxX: 20,
            minY: 0,
            maxY: 6,
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                axisNameWidget: Text('Rating',
                    style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant)),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (val, _) => Text(
                    val.toInt().toString(),
                    style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                axisNameWidget: Text('Ratio (g/g)',
                    style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant)),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: 2,
                  getTitlesWidget: (val, _) => Text(
                    val.toInt().toString(),
                    style: TextStyle(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (val) => FlLine(
                color: colorScheme.outlineVariant.withOpacity(0.4),
                strokeWidth: 1,
              ),
              getDrawingVerticalLine: (val) => FlLine(
                color: colorScheme.outlineVariant.withOpacity(0.4),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }

  // ── Espresso Stats ──────────────────────────────────────────────────────────

  Widget _buildEspressoStats(BuildContext context, InsightsState state) {
    final espressos = state.brews.where((b) => b.brewType == 'espresso').toList();
    if (espressos.isEmpty) return const SizedBox.shrink();

    final avgTemp = espressos.map((b) => b.temperature).reduce((a, b) => a + b) /
        espressos.length;
    final avgGrind = espressos.map((b) => b.grindSize).reduce((a, b) => a + b) /
        espressos.length;

    return _sectionCard(
      context,
      title: 'Espresso Summary',
      icon: Icons.local_cafe_rounded,
      child: Row(
        children: [
          Expanded(
            child: _miniStatTile(
                context, 'Avg Temp', '${avgTemp.toStringAsFixed(0)}°C',
                Icons.thermostat_rounded),
          ),
          Expanded(
            child: _miniStatTile(
                context, 'Avg Grind', avgGrind.toStringAsFixed(1),
                Icons.grain_rounded),
          ),
          Expanded(
            child: _miniStatTile(
                context, 'Count', espressos.length.toString(),
                Icons.local_cafe_outlined),
          ),
        ],
      ),
    );
  }

  Widget _miniStatTile(
      BuildContext context, String label, String value, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                )),
      ],
    );
  }

  // ── Shared Section Card ─────────────────────────────────────────────────────

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _ChipOption {
  final String label;
  final String value;
  const _ChipOption(this.label, this.value);
}
