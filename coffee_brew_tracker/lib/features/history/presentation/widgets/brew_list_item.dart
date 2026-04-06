import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';
import 'package:coffee_brew_tracker/core/utils/date_formatter.dart';
import 'package:coffee_brew_tracker/core/widgets/rating_stars.dart';

class BrewListItem extends StatelessWidget {
  final BrewEntity brew;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const BrewListItem({
    super.key,
    required this.brew,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEspresso = brew.brewType == 'espresso';
    final icon = isEspresso ? Icons.coffee_maker : Icons.coffee;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Slidable(
        key: Key(brew.id.toString()),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Brew?'),
                    content: const Text('Are you sure you want to delete this record?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          onDelete();
                        },
                        style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          isEspresso ? 'Espresso' : 'Pour Over',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (brew.createdAt != null)
                      Text(
                        DateFormatter.formatRelative(brew.createdAt!),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  brew.coffeeName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (brew.origin != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    brew.origin!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat(context, 'Ratio', '1:${brew.ratio.toStringAsFixed(1)}'),
                    _buildStat(context, 'In', _formatWeight(brew.coffeeWeight)),
                    if (!isEspresso && brew.waterWeight != null) ...[
                      _buildStat(context, 'Out', _formatWeight(brew.waterWeight!)),
                    ],
                    _buildStat(context, 'Time', DateFormatter.formatBrewTime(brew.brewTime)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingStars(rating: brew.rating, size: 18),
                    if (brew.notes != null && brew.notes!.isNotEmpty)
                      Icon(Icons.notes, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  String _formatWeight(double weight) {
    if (weight == weight.truncateToDouble()) {
      return '${weight.toInt()}g';
    }
    return '${weight.toStringAsFixed(1)}g';
  }
}
