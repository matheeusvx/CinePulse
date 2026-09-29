import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PulseScoreCard extends StatelessWidget {
  const PulseScoreCard({
    super.key,
    required this.title,
    required this.averageTen,
    required this.story,
    required this.acting,
    required this.visual,
    required this.soundtrack,
  });

  final String title;
  final double averageTen;
  final double? story;
  final double? acting;
  final double? visual;
  final double? soundtrack;

  @override
  Widget build(BuildContext context) => Container(
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
            const Icon(Icons.show_chart_rounded, color: AppColors.secondary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Seu PulseScore • $title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${averageTen.toStringAsFixed(1)} / 10',
              semanticsLabel:
                  'Média pessoal ${averageTen.toStringAsFixed(1)} de 10',
              style: const TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _CriterionBar(label: 'História', value: story),
        _CriterionBar(label: 'Atuação', value: acting),
        _CriterionBar(label: 'Visual', value: visual),
        _CriterionBar(label: 'Trilha sonora', value: soundtrack),
      ],
    ),
  );
}

class _CriterionBar extends StatelessWidget {
  const _CriterionBar({required this.label, required this.value});
  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
            Text(
              value == null
                  ? 'Não avaliado'
                  : '${value!.toStringAsFixed(1)} / 5',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (value != null) ...[
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value! / 5,
              minHeight: 6,
              backgroundColor: AppColors.surfaceStrong,
              valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
            ),
          ),
        ],
      ],
    ),
  );
}
