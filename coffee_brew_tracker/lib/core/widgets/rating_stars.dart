import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final ValueChanged<int>? onChanged;
  final double size;

  const RatingStars({
    super.key,
    required this.rating,
    this.onChanged,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isSelected = index < rating;
        return GestureDetector(
          onTap: onChanged != null ? () => onChanged!(index + 1) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              color: Theme.of(context).colorScheme.primary,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
