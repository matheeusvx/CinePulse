import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/spoiler_safe_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
      children: [
        // Profile Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
              ),
              child: const CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFF1E1B4B),
                child: Text(
                  'CM',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cauã Ferreira Muniz',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                        ),
                  ),
                  const Text(
                    '@caua.muniz • Brand & UI Designer',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Configurações',
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Metrics Row
        const Row(
          children: [
            Expanded(child: _Metric(value: '142', label: 'Assistidos')),
            SizedBox(width: 10),
            Expanded(child: _Metric(value: '38', label: 'Reviews')),
            SizedBox(width: 10),
            Expanded(child: _Metric(value: '6', label: 'Listas')),
          ],
        ),
        const SizedBox(height: 24),

        // DIFFERENTIAL: PulseMatch Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.surfaceStrong),
          ),
          child: Row(
            children: [
              // Circular Gauge
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 76,
                    height: 76,
                    child: CircularProgressIndicator(
                      value: 0.88,
                      strokeWidth: 7,
                      backgroundColor: AppColors.surfaceStrong,
                      valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '88%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'MATCH',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PULSE MATCH™',
                        style: TextStyle(
                          color: Color(0xFFC4B5FD),
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Alta afinidade comunitária',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Sintonia com o grupo em Ficção Científica, Suspense e Drama.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),

        // Diário Recente
        const Text(
          'Diário Recente',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        const SpoilerSafeCard(
          movieTitle: 'Duna: Parte 2 (2024)',
          reviewAuthor: 'Avaliado com 4.8 estrelas',
          rating: 4.8,
          spoilerText:
              'Obra-prima audiovisual incontestável. A direção de som nos vermes de areia e o arco de Paul Atreides elevam a ficção científica.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.surfaceStrong),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interestelar (2014)',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: AppColors.warning, size: 18),
                      SizedBox(width: 4),
                      Text(
                        '5.0',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '"A trilha sonora de Hans Zimmer e a viagem no buraco de minhoca continuam insuperáveis no cinema moderno."',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
