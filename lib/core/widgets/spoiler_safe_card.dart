import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SpoilerSafeCard extends StatefulWidget {
  const SpoilerSafeCard({
    super.key,
    required this.title,
    required this.rating,
    required this.reviewText,
    required this.containsSpoiler,
  });

  final String title;
  final double rating;
  final String reviewText;
  final bool containsSpoiler;

  @override
  State<SpoilerSafeCard> createState() => _SpoilerSafeCardState();
}

class _SpoilerSafeCardState extends State<SpoilerSafeCard> {
  bool _revealed = false;

  @override
  void didUpdateWidget(covariant SpoilerSafeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title ||
        oldWidget.reviewText != widget.reviewText ||
        oldWidget.containsSpoiler != widget.containsSpoiler) {
      _revealed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hidden = widget.containsSpoiler && !_revealed;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hidden ? AppColors.primary : AppColors.surfaceStrong,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      'Sua review',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.star_rounded,
                color: AppColors.warning,
                size: 18,
              ),
              Text(
                widget.rating.toStringAsFixed(1),
                semanticsLabel:
                    'Sua nota ${widget.rating.toStringAsFixed(1)} de 5',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (hidden)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF16152B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Esta review contém spoiler.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton.icon(
                    onPressed: () => setState(() => _revealed = true),
                    icon: const Icon(Icons.shield_outlined),
                    label: const Text('Revelar spoiler'),
                  ),
                ],
              ),
            )
          else
            Text(widget.reviewText, style: const TextStyle(height: 1.4)),
        ],
      ),
    );
  }
}
