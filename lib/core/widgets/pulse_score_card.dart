import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PulseScoreCard extends StatelessWidget {
  const PulseScoreCard({
    super.key,
    this.title = 'PulseScore™ da Comunidade',
    this.average = '9.6',
    this.story = 0.96,
    this.acting = 0.98,
    this.visual = 1.0,
    this.soundtrack = 0.94,
  });

  final String title;
  final String average;
  final double story;
  final double acting;
  final double visual;
  final double soundtrack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.show_chart_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceStrong,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '$average / 10',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _CriterionBar(label: 'História & Roteiro', value: story, scoreText: '4.8 ★'),
          const SizedBox(height: 12),
          _CriterionBar(label: 'Atuação & Elenco', value: acting, scoreText: '4.9 ★'),
          const SizedBox(height: 12),
          _CriterionBar(label: 'Direção Visual & Fotografia', value: visual, scoreText: '5.0 ★'),
          const SizedBox(height: 12),
          _CriterionBar(label: 'Trilha Sonora & Som', value: soundtrack, scoreText: '4.7 ★'),
        ],
      ),
    );
  }
}

class _CriterionBar extends StatelessWidget {
  const _CriterionBar({
    required this.label,
    required this.value,
    required this.scoreText,
  });

  final String label;
  final double value;
  final String scoreText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              scoreText,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Container(
                height: 6,
                color: AppColors.surfaceStrong,
              ),
              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: 6,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
