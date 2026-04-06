import 'package:flutter/material.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/core/utils/date_formatter.dart';
import 'package:coffee_brew_tracker/core/widgets/rating_stars.dart';
import 'package:coffee_brew_tracker/core/widgets/section_header.dart';

class BrewDetailScreen extends StatelessWidget {
  final BrewEntity brew;

  const BrewDetailScreen({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    final isEspresso = brew.brewType == 'espresso';

    return Scaffold(
      appBar: AppBar(
        title: Text(isEspresso ? 'Espresso Details' : 'Pour Over Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Card
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          brew.coffeeName,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RatingStars(rating: brew.rating),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (brew.createdAt != null)
                    Text(
                      DateFormatter.formatDate(brew.createdAt!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  const SizedBox(height: 16),
                  if (brew.origin != null || brew.roastLevel != null || brew.process != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (brew.origin != null && brew.origin!.isNotEmpty) _buildChip(context, brew.origin!),
                        if (brew.roastLevel != null && brew.roastLevel!.isNotEmpty) _buildChip(context, brew.roastLevel!),
                        if (brew.process != null && brew.process!.isNotEmpty) _buildChip(context, brew.process!),
                      ],
                    ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          const SectionHeader(title: 'Recipe Details'),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (isEspresso) ...[
                    _buildDetailRow(context, 'Dose (In)', '${_formatWeight(brew.coffeeWeight)}g'),
                    const Divider(),
                    _buildDetailRow(context, 'Yield (Out)', '${_formatWeight(brew.brewYield ?? brew.waterWeight ?? 0)}g'),
                    const Divider(),
                    _buildDetailRow(context, 'Extraction Time', '${brew.brewTime}s'),
                  ] else ...[
                    if (brew.brewMethod != null && brew.brewMethod!.isNotEmpty) ...[
                      _buildDetailRow(context, 'Method', brew.brewMethod!),
                      const Divider(),
                    ],
                    _buildDetailRow(context, 'Coffee (In)', '${_formatWeight(brew.coffeeWeight)}g'),
                    const Divider(),
                    if (brew.waterWeight != null) ...[
                      _buildDetailRow(context, 'Water (Out)', '${_formatWeight(brew.waterWeight!)}g'),
                      const Divider(),
                    ],
                    _buildDetailRow(context, 'Brew Time', DateFormatter.formatBrewTime(brew.brewTime)),
                  ],
                  const Divider(),
                  _buildDetailRow(context, 'Ratio', '1 : ${brew.ratio.toStringAsFixed(1)}'),
                  const Divider(),
                  _buildDetailRow(context, 'Grind Size', '${brew.grindSize}'),
                  const Divider(),
                  _buildDetailRow(context, 'Temperature', '${brew.temperature}°C'),
                ],
              ),
            ),
          ),

          if ((brew.recipe != null && brew.recipe!.isNotEmpty) || (brew.notes != null && brew.notes!.isNotEmpty)) ...[
            const SizedBox(height: 24),
            const SectionHeader(title: 'Notes & Steps'),
            if (brew.recipe != null && brew.recipe!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Recipe / Steps:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(brew.recipe!, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],
            if (brew.notes != null && brew.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Tasting Notes:', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(brew.notes!, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _formatWeight(double weight) {
    if (weight == weight.truncateToDouble()) {
      return weight.toInt().toString();
    }
    return weight.toStringAsFixed(1);
  }
}
