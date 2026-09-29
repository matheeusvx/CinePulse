import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/mood_tag_chip.dart';
import '../../../core/widgets/pulse_score_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/spoiler_safe_card.dart';
import '../../catalog/catalog_dependencies.dart';
import '../../catalog/data/models/media_item.dart';
import '../../catalog/data/models/mood_tag.dart';
import '../../catalog/data/models/rating_entry.dart';
import '../../catalog/data/repositories/catalog_repository.dart';
import '../../catalog/presentation/widgets/catalog_media_card.dart';
import '../../catalog/presentation/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.catalogDependencies});

  final CatalogDependencies? catalogDependencies;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedMoodIndex = 0;
  Future<List<MediaItem>>? _trending;
  Future<List<MediaItem>>? _moodResults;
  Stream<List<RatingEntry>>? _ratingsStream;

  @override
  void initState() {
    super.initState();
    _reloadTrending();
    _reloadMood();
    _ratingsStream = widget.catalogDependencies?.ratings.watchAll();
  }

  void _reloadRatings() => setState(() {
    _ratingsStream = widget.catalogDependencies?.ratings.watchAll();
  });

  Widget _emptyHighlight(String message) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.surfaceStrong),
    ),
    child: Text(
      message,
      style: const TextStyle(color: AppColors.textSecondary),
    ),
  );

  Widget _personalHighlights() => StreamBuilder<List<RatingEntry>>(
    stream: _ratingsStream,
    builder: (context, snapshot) {
      RatingEntry? withScore;
      RatingEntry? withReview;
      for (final entry in snapshot.data ?? const <RatingEntry>[]) {
        if (withScore == null && entry.pulseScore?.averageFive != null) {
          withScore = entry;
        }
        if (withReview == null && entry.hasReview) withReview = entry;
      }
      if (snapshot.hasError) {
        return Column(
          children: [
            const Text('Não foi possível carregar seus destaques.'),
            TextButton(
              onPressed: _reloadRatings,
              child: const Text('Tentar novamente'),
            ),
          ],
        );
      }
      if (_ratingsStream != null &&
          snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      final score = withScore?.pulseScore;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Seu PulseScore'),
          const SizedBox(height: 12),
          score == null
              ? _emptyHighlight(
                  'Detalhe história, atuação, visual ou trilha em uma avaliação para ver seu PulseScore.',
                )
              : PulseScoreCard(
                  title: withScore!.title,
                  averageTen: score.averageTen!,
                  story: score.story,
                  acting: score.acting,
                  visual: score.visual,
                  soundtrack: score.soundtrack,
                ),
          const SizedBox(height: 26),
          const SectionTitle(title: 'Sua review • Spoiler Safe'),
          const SizedBox(height: 12),
          withReview == null
              ? _emptyHighlight(
                  'Escreva uma review ao avaliar um título. Se houver spoiler, ela ficará oculta até você revelar.',
                )
              : SpoilerSafeCard(
                  key: ValueKey(
                    '${withReview.mediaKey}_${withReview.updatedAt}',
                  ),
                  title: withReview.title,
                  rating: withReview.rating,
                  reviewText: withReview.reviewText,
                  containsSpoiler: withReview.containsSpoiler,
                ),
        ],
      );
    },
  );

  void _reloadTrending() => setState(() {
    _trending = widget.catalogDependencies?.catalog.trending();
  });

  void _reloadMood() => setState(() {
    _moodResults = widget.catalogDependencies?.catalog.byMood(
      MoodTag.values[_selectedMoodIndex],
    );
  });

  Widget _mediaStrip(Future<List<MediaItem>>? future, VoidCallback retry) {
    final dependencies = widget.catalogDependencies;
    if (dependencies == null || !dependencies.catalog.isConfigured) {
      return const Text(
        'Catálogo não configurado. Defina TMDB_READ_ACCESS_TOKEN em config/local.json.',
      );
    }
    return FutureBuilder<List<MediaItem>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox(
            height: 292,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          final error = snapshot.error;
          return Column(
            children: [
              Text(
                error is CatalogException
                    ? error.message
                    : 'Não foi possível carregar os títulos.',
              ),
              TextButton(
                onPressed: retry,
                child: const Text('Tentar novamente'),
              ),
            ],
          );
        }
        final items = snapshot.data ?? const <MediaItem>[];
        if (items.isEmpty) return const Text('Nenhum título disponível agora.');
        return SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, index) => CatalogMediaCard(
              media: items[index],
              dependencies: dependencies,
            ),
          ),
        );
      },
    );
  }

  final List<({String label, IconData icon})> _moods = const [
    (label: 'Tenso', icon: Icons.bolt_rounded),
    (label: 'Leve', icon: Icons.coffee_rounded),
    (label: 'Reflexivo', icon: Icons.lightbulb_outline_rounded),
    (label: 'Épico', icon: Icons.local_fire_department_rounded),
    (label: 'Emocionante', icon: Icons.favorite_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final isWide = MediaQuery.sizeOf(context).width >= 760;
        final horizontalPadding = isWide ? 32.0 : 20.0;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                isWide ? 28 : 18,
                horizontalPadding,
                28,
              ),
              children: [
                // App Bar Header
                Row(
                  children: [
                    Image.asset(
                      'assets/brand/cinepulse_symbol_transparente.png',
                      width: 44,
                      height: 44,
                      semanticLabel: 'Símbolo CinePulse',
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
                  ],
                ),
                const SizedBox(height: 22),

                // Search Field
                TextField(
                  readOnly: true,
                  onTap: () {
                    final dependencies = widget.catalogDependencies;
                    if (dependencies == null) return;
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => SearchPage(dependencies: dependencies),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar filmes ou séries...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textSecondary,
                    ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'CINEPULSE',
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
                        'Descubra filmes e séries e registre o que cada sessão despertou em você.',
                        style: TextStyle(
                          height: 1.4,
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
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
                          if (_selectedMoodIndex == index) return;
                          _selectedMoodIndex = index;
                          _reloadMood();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                _mediaStrip(_moodResults, _reloadMood),
                const SizedBox(height: 26),

                // Tendências semanais do TMDB.
                const SectionTitle(title: 'Em alta no TMDB'),
                const SizedBox(height: 14),
                _mediaStrip(_trending, _reloadTrending),
                const SizedBox(height: 26),

                _personalHighlights(),
              ],
            ),
          ),
        );
      },
    );
  }
}
