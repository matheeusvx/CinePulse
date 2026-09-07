import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/media_poster.dart';
import '../../../core/widgets/section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.play_arrow_rounded),
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
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextField(
          readOnly: true,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Busca será conectada ao catálogo no CP5.'),
              ),
            );
          },
          decoration: const InputDecoration(
            hintText: 'Buscar filmes, séries ou pessoas',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFF5B21B6)],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seu gosto, além das estrelas.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'No CinePulse, a nota pode considerar história, atuação, visual e trilha — e ainda comparar afinidade com seus amigos.',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const SectionTitle(title: 'Em alta na comunidade'),
        const SizedBox(height: 14),
        SizedBox(
          height: 292,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              MediaPoster(
                title: 'Horizonte Zero',
                subtitle: 'Filme • Ficção científica',
                icon: Icons.rocket_launch_rounded,
                score: 4.4,
              ),
              SizedBox(width: 14),
              MediaPoster(
                title: 'Último Ato',
                subtitle: 'Série • Drama',
                icon: Icons.theater_comedy_rounded,
                score: 4.7,
              ),
              SizedBox(width: 14),
              MediaPoster(
                title: 'Neon City',
                subtitle: 'Filme • Thriller',
                icon: Icons.apartment_rounded,
                score: 4.2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Diferenciais do MVP'),
        const SizedBox(height: 12),
        const _FeatureTile(
          icon: Icons.tune_rounded,
          title: 'PulseScore',
          description: 'Avaliação por critérios, não só uma nota isolada.',
        ),
        const _FeatureTile(
          icon: Icons.people_alt_outlined,
          title: 'PulseMatch',
          description: 'Compatibilidade de gosto entre amigos e perfis.',
        ),
        const _FeatureTile(
          icon: Icons.mood_rounded,
          title: 'MoodTags',
          description: 'Descoberta por clima: leve, tenso, emocionante e mais.',
        ),
        const _FeatureTile(
          icon: Icons.visibility_off_outlined,
          title: 'Spoiler Safe',
          description: 'Reviews com conteúdo sensível oculto por padrão.',
        ),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surfaceStrong,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
