import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../catalog_dependencies.dart';
import '../data/models/media_item.dart';
import '../data/models/rating_entry.dart';
import '../data/repositories/catalog_repository.dart';
import 'widgets/media_artwork.dart';
import 'widgets/personal_review_card.dart';
import 'widgets/rating_sheet.dart';
import 'widgets/watchlist_button.dart';

class MediaDetailPage extends StatefulWidget {
  const MediaDetailPage({
    super.key,
    required this.media,
    required this.dependencies,
  });

  final MediaItem media;
  final CatalogDependencies dependencies;

  @override
  State<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends State<MediaDetailPage> {
  MediaItem? _details;
  RatingEntry? _entry;
  String? _error;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final media = await widget.dependencies.catalog.getDetails(
        widget.media.mediaType,
        widget.media.tmdbId,
      );
      final entry = await widget.dependencies.ratings.getEntry(media.mediaKey);
      if (!mounted) return;
      setState(() {
        _details = media;
        _entry = entry;
      });
    } catch (error) {
      if (!mounted) return;
      setState(
        () => _error = error is CatalogException
            ? error.message
            : 'Não foi possível carregar o detalhe. Tente novamente.',
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _rate() async {
    final media = _details;
    if (media == null) return;
    final selected = await showModalBottomSheet<RatingDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) => RatingSheet(initial: _entry),
    );
    if (selected == null || !mounted) return;
    setState(() => _saving = true);
    try {
      await widget.dependencies.ratings.save(media, selected);
      final updated = await widget.dependencies.ratings.getEntry(
        media.mediaKey,
      );
      if (!mounted) return;
      setState(() => _entry = updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Avaliação salva. Item removido da Watchlist.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível salvar a avaliação.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.media.title)),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: _load,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                ),
              )
            : _content(_details!),
      ),
    );
  }

  Widget _content(MediaItem media) {
    final extra = media.mediaType == MediaType.movie
        ? (media.runtimeMinutes == null ? null : '${media.runtimeMinutes} min')
        : (media.seasonCount == null
              ? null
              : '${media.seasonCount} temporada${media.seasonCount == 1 ? '' : 's'}');
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 210,
                child: MediaArtwork(
                  url: media.backdropUrl ?? media.posterUrl,
                  semanticLabel: 'Imagem de ${media.title}',
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 94,
                    height: 140,
                    child: MediaArtwork(
                      url: media.posterUrl,
                      semanticLabel: 'Pôster de ${media.title}',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        media.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${media.typeLabel} • ${media.year}',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      if (extra != null) ...[
                        const SizedBox(height: 5),
                        Text(
                          extra,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        'TMDB ${media.voteAverage.toStringAsFixed(1)}/10',
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              media.genres.isEmpty
                  ? 'Gêneros indisponíveis'
                  : media.genres.join(' • '),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 22),
            Text(
              'Sinopse',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              media.overview.isEmpty ? 'Sinopse indisponível.' : media.overview,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                WatchlistButton(
                  media: media,
                  repository: widget.dependencies.watchlist,
                ),
                FilledButton.icon(
                  onPressed: _saving ? null : _rate,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.star_rounded),
                  label: Text(
                    _entry == null
                        ? 'Assistido / Avaliar'
                        : 'Sua nota: ${_entry!.rating.toStringAsFixed(1)} • Alterar',
                  ),
                ),
              ],
            ),
            if (_entry?.hasReview == true) ...[
              const SizedBox(height: 24),
              PersonalReviewCard(
                key: ValueKey(_entry!.reviewText),
                entry: _entry!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
