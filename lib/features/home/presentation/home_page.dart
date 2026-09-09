import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/media_poster.dart';
import '../../../core/widgets/mood_tag_chip.dart';
import '../../../core/widgets/pulse_score_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/spoiler_safe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedMoodIndex = 0;

  final List<({String label, IconData icon})> _moods = const [
    (label: 'Tenso', icon: Icons.bolt_rounded),
    (label: 'Leve', icon: Icons.coffee_rounded),
    (label: 'Reflexivo', icon: Icons.lightbulb_outline_rounded),
    (label: 'Épico', icon: Icons.local_fire_department_rounded),
    (label: 'Emocionante', icon: Icons.favorite_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        // App Bar Header
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CinePulse',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'O que vale a próxima sessão?',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Notificações',
              onPressed: () {},
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_none_rounded),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // Search Field
        TextField(
          readOnly: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Busca será conectada ao catálogo no CP5.'),
              ),
            );
          },
          decoration: InputDecoration(
            hintText: 'Buscar filmes, séries ou pessoas...',
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Hero Banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF2D1B69), Color(0xFF1E1B4B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: const Color(0xFF312E81)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'PULSE MATCH',
                  style: TextStyle(
                    color: Color(0xFFC4B5FD),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Seu gosto, além das estrelas.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Avalie por história, atuação, visual e trilha — e conecte sua afinidade com a comunidade.',
                style: TextStyle(height: 1.4, color: AppColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),

        // MoodTags Section
        const SectionTitle(title: 'Para o seu humor'),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _moods.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final mood = _moods[index];
              return MoodTagChip(
                label: mood.label,
                icon: mood.icon,
                isSelected: _selectedMoodIndex == index,
                onTap: () {
                  setState(() {
                    _selectedMoodIndex = index;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 26),

        // Em alta na comunidade
        const SectionTitle(title: 'Em alta na comunidade'),
        const SizedBox(height: 14),
        SizedBox(
          height: 292,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              MediaPoster(
                title: 'Duna: Parte 2',
                subtitle: 'Filme • Ficção científica',
                icon: Icons.rocket_launch_rounded,
                score: 4.8,
              ),
              SizedBox(width: 14),
              MediaPoster(
                title: 'Severance',
                subtitle: 'Série • Suspense',
                icon: Icons.theater_comedy_rounded,
                score: 4.7,
              ),
              SizedBox(width: 14),
              MediaPoster(
                title: 'Interestelar',
                subtitle: 'Filme • Ficção / Drama',
                icon: Icons.apartment_rounded,
                score: 4.9,
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),

        // Destaque PulseScore
        const SectionTitle(title: 'Destaque PulseScore™'),
        const SizedBox(height: 12),
        const PulseScoreCard(
          title: 'Duna: Parte 2 — Médias',
          average: '9.6',
          story: 0.96,
          acting: 0.98,
          visual: 1.0,
          soundtrack: 0.94,
        ),
        const SizedBox(height: 26),

        // Destaque Spoiler Safe
        const SectionTitle(title: 'Review com Spoiler Safe™'),
        const SizedBox(height: 12),
        const SpoilerSafeCard(
          movieTitle: 'Duna: Parte 2 (2024)',
          reviewAuthor: 'Por Cauã Ferreira Muniz (@caua.muniz)',
          rating: 4.8,
          spoilerText:
              'A sequência da batalha final em Arrakis e a ascensão ao trono imperial encerram o arco de Paul de maneira avassaladora e sombria.',
        ),
      ],
    );
  }
}
