import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/pulse_score_card.dart';
import '../../catalog/catalog_dependencies.dart';
import '../../catalog/data/models/mood_tag.dart';
import '../../catalog/data/models/rating_entry.dart';
import '../../catalog/data/models/watchlist_entry.dart';
import '../../catalog/presentation/widgets/personal_review_card.dart';
import '../data/models/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.onSignOut, this.dependencies});
  final Future<void> Function() onSignOut;
  final CatalogDependencies? dependencies;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Stream<Profile?>? _profileStream;
  Stream<List<RatingEntry>>? _ratingsStream;
  Stream<List<WatchlistEntry>>? _watchlistStream;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  void _connect() {
    _profileStream = widget.dependencies?.profile?.watchMine();
    _ratingsStream = widget.dependencies?.ratings.watchAll();
    _watchlistStream = widget.dependencies?.watchlist.watchAll();
  }

  void _retry() => setState(_connect);

  @override
  Widget build(BuildContext context) => StreamBuilder<Profile?>(
    stream: _profileStream,
    builder: (context, profileSnapshot) => StreamBuilder<List<RatingEntry>>(
      stream: _ratingsStream,
      builder: (context, ratingSnapshot) => StreamBuilder<List<WatchlistEntry>>(
        stream: _watchlistStream,
        builder: (context, watchlistSnapshot) {
          final profile = profileSnapshot.data;
          final ratings = ratingSnapshot.data ?? const <RatingEntry>[];
          final watchlist = watchlistSnapshot.data ?? const <WatchlistEntry>[];
          final email = widget.dependencies?.profile?.currentEmail;
          final name = profile?.displayName?.trim().isNotEmpty == true
              ? profile!.displayName!.trim()
              : (email?.isNotEmpty == true ? email! : 'Seu perfil');
          final username = profile?.username?.trim();
          final reviews = ratings.where((entry) => entry.hasReview).toList();
          RatingEntry? latestScore;
          for (final entry in ratings) {
            if (entry.pulseScore?.averageFive != null) {
              latestScore = entry;
              break;
            }
          }
          final average = ratings.isEmpty
              ? null
              : ratings.map((entry) => entry.rating).reduce((a, b) => a + b) /
                    ratings.length;
          final counts = <MoodTag, int>{};
          for (final entry in ratings) {
            for (final tag in entry.moodTags) {
              counts[tag] = (counts[tag] ?? 0) + 1;
            }
          }
          final favoriteMoods = counts.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));
          final loading =
              widget.dependencies != null &&
              (profileSnapshot.connectionState == ConnectionState.waiting ||
                  ratingSnapshot.connectionState == ConnectionState.waiting ||
                  watchlistSnapshot.connectionState == ConnectionState.waiting);
          final error =
              profileSnapshot.hasError ||
              ratingSnapshot.hasError ||
              watchlistSnapshot.hasError;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
            children: [
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
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF1E1B4B),
                      child: Text(
                        name.isEmpty ? '?' : name[0].toUpperCase(),
                        style: const TextStyle(
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
                          name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        if (username?.isNotEmpty == true)
                          Text(
                            '@$username',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (loading) const Center(child: CircularProgressIndicator()),
              if (error)
                Column(
                  children: [
                    const Text('Não foi possível carregar seu perfil.'),
                    TextButton(
                      onPressed: _retry,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              if (!loading && !error) ...[
                Row(
                  children: [
                    _Metric(value: '${ratings.length}', label: 'Assistidos'),
                    const SizedBox(width: 8),
                    _Metric(value: '${reviews.length}', label: 'Reviews'),
                    const SizedBox(width: 8),
                    _Metric(value: '${watchlist.length}', label: 'Watchlist'),
                    const SizedBox(width: 8),
                    _Metric(
                      value: average?.toStringAsFixed(1) ?? '—',
                      label: 'Nota média',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Seu PulseScore',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                if (latestScore?.pulseScore case final score?)
                  PulseScoreCard(
                    title: latestScore!.title,
                    averageTen: score.averageTen!,
                    story: score.story,
                    acting: score.acting,
                    visual: score.visual,
                    soundtrack: score.soundtrack,
                  )
                else
                  const Text(
                    'Detalhe uma avaliação para acompanhar seu PulseScore.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                const SizedBox(height: 24),
                const Text(
                  'PulseMatch',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Compare seu gosto quando houver dados suficientes de outra pessoa.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),
                const Text(
                  'MoodTags mais usadas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                if (favoriteMoods.isEmpty)
                  const Text(
                    'Avalie títulos e escolha MoodTags para ver seu progresso.',
                    style: TextStyle(color: AppColors.textSecondary),
                  )
                else
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final mood in favoriteMoods.take(3))
                        Chip(label: Text('${mood.key.label} • ${mood.value}')),
                    ],
                  ),
                const SizedBox(height: 24),
                const Text(
                  'Reviews recentes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                if (reviews.isEmpty)
                  const Text(
                    'Suas reviews aparecerão aqui depois da primeira avaliação com texto.',
                    style: TextStyle(color: AppColors.textSecondary),
                  )
                else
                  for (final entry in reviews.take(3)) ...[
                    PersonalReviewCard(
                      key: ValueKey(entry.mediaKey),
                      entry: entry,
                      heading:
                          '${entry.title} • ${entry.rating.toStringAsFixed(1)} ★',
                    ),
                    const SizedBox(height: 12),
                  ],
                const SizedBox(height: 16),
              ],
              const Text(
                'Sobre e créditos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              const Text(
                'CinePulse 1.0.0+1',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 14),
              SvgPicture.asset(
                'assets/brand/tmdb_logo_flutter.svg',
                width: 128,
                height: 22,
                alignment: Alignment.centerLeft,
                semanticsLabel: 'The Movie Database, TMDB',
              ),
              const SizedBox(height: 8),
              const Text(
                'This product uses the TMDB API but is not endorsed or certified by TMDB.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () async {
                  try {
                    await widget.onSignOut();
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Não foi possível sair. Tente novamente.',
                          ),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sair da conta'),
              ),
            ],
          );
        },
      ),
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 3),
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
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
