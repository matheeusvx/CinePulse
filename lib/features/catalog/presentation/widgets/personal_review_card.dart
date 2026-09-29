import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/rating_entry.dart';

class PersonalReviewCard extends StatefulWidget {
  const PersonalReviewCard({
    super.key,
    required this.entry,
    this.heading = 'Sua review',
  });

  final RatingEntry entry;
  final String heading;

  @override
  State<PersonalReviewCard> createState() => _PersonalReviewCardState();
}

class _PersonalReviewCardState extends State<PersonalReviewCard> {
  bool _revealed = false;

  @override
  void didUpdateWidget(covariant PersonalReviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.mediaKey != widget.entry.mediaKey ||
        oldWidget.entry.reviewText != widget.entry.reviewText ||
        oldWidget.entry.containsSpoiler != widget.entry.containsSpoiler) {
      _revealed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hidden = widget.entry.containsSpoiler && !_revealed;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.heading,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (hidden) ...[
            const Text(
              'Esta review contém spoiler.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            TextButton(
              onPressed: () => setState(() => _revealed = true),
              child: const Text('Revelar spoiler'),
            ),
          ] else
            Text(widget.entry.reviewText),
        ],
      ),
    );
  }
}
