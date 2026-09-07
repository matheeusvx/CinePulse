import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Diário',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Seu histórico de filmes e séries assistidos.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        const _DiaryItem(
          title: 'Último Ato',
          date: 'Hoje',
          rating: '4,5',
        ),
        const _DiaryItem(
          title: 'Horizonte Zero',
          date: 'Ontem',
          rating: '4,0',
        ),
      ],
    );
  }
}

class _DiaryItem extends StatelessWidget {
  const _DiaryItem({
    required this.title,
    required this.date,
    required this.rating,
  });

  final String title;
  final String date;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.surfaceStrong,
            child: Icon(Icons.movie_outlined, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, color: AppColors.warning, size: 18),
          const SizedBox(width: 4),
          Text(rating, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
