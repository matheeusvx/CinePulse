import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../catalog_dependencies.dart';
import '../data/models/media_item.dart';
import '../data/repositories/catalog_repository.dart';
import 'widgets/media_artwork.dart';
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
  double? _rating;
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
      final rating = await widget.dependencies.ratings.getRating(
        media.mediaKey,
      );
      if (!mounted) return;
      setState(() {
        _details = media;
        _rating = rating;
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
    final selected = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (context) => _RatingSheet(initialRating: _rating),
    );
    if (selected == null || !mounted) return;
    setState(() => _saving = true);
    try {
      await widget.dependencies.ratings.save(media, selected);
      if (!mounted) return;
      setState(() => _rating = selected);
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
                child: MediaArtwork(url: media.backdropUrl ?? media.posterUrl),
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
                    child: MediaArtwork(url: media.posterUrl),
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
                    _rating == null
                        ? 'Assistido / Avaliar'
                        : 'Sua nota: ${_rating!.toStringAsFixed(1)} • Alterar',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingSheet extends StatefulWidget {
  const _RatingSheet({required this.initialRating});

  final double? initialRating;

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  double? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Marcar como assistido',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolha uma nota de 0.5 a 5.0.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var halfStars = 1; halfStars <= 10; halfStars++)
                  ChoiceChip(
                    label: Text((halfStars / 2).toStringAsFixed(1)),
                    selected: _selected == halfStars / 2,
                    onSelected: (_) =>
                        setState(() => _selected = halfStars / 2),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _selected == null
                  ? null
                  : () => Navigator.of(context).pop(_selected),
              child: const Text('Salvar avaliação'),
            ),
          ],
        ),
      ),
    );
  }
}
