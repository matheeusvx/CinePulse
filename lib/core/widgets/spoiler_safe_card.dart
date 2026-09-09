import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SpoilerSafeCard extends StatefulWidget {
  const SpoilerSafeCard({
    super.key,
    required this.movieTitle,
    required this.reviewAuthor,
    required this.rating,
    required this.spoilerText,
  });

  final String movieTitle;
  final String reviewAuthor;
  final double rating;
  final String spoilerText;

  @override
  State<SpoilerSafeCard> createState() => _SpoilerSafeCardState();
}

class _SpoilerSafeCardState extends State<SpoilerSafeCard> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _isRevealed ? AppColors.surfaceStrong : AppColors.primary.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieTitle,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  Text(
                    widget.reviewAuthor,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppColors.warning, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    widget.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              setState(() {
                _isRevealed = !_isRevealed;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isRevealed ? AppColors.surfaceStrong.withValues(alpha: 0.5) : const Color(0xFF16152B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isRevealed ? Colors.transparent : AppColors.primary.withValues(alpha: 0.4),
                ),
              ),
              child: _isRevealed
                  ? Text(
                      widget.spoilerText,
                      style: const TextStyle(height: 1.4, fontSize: 13),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield_outlined, color: AppColors.primary, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'SPOILER SAFE • Toque para revelar',
                          style: TextStyle(
                            color: Color(0xFFC4B5FD),
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
