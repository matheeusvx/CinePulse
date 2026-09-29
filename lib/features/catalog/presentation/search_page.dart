import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../catalog_dependencies.dart';
import '../data/models/media_item.dart';
import '../data/repositories/catalog_repository.dart';
import 'media_detail_page.dart';
import 'widgets/media_artwork.dart';
import 'widgets/watchlist_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.dependencies});

  final CatalogDependencies dependencies;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';
  List<MediaItem> _results = const [];
  String? _error;
  bool _loading = false;
  bool _searched = false;
  int _requestId = 0;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _requestId++;
    final query = value.trim();
    setState(() {
      _query = query;
      _error = null;
      _loading = false;
      _searched = false;
      _results = const [];
    });
    if (query.length < 2 || !widget.dependencies.catalog.isConfigured) return;
    _debounce = Timer(const Duration(milliseconds: 400), _search);
  }

  Future<void> _search() async {
    if (_query.length < 2 || !widget.dependencies.catalog.isConfigured) return;
    final id = ++_requestId;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await widget.dependencies.catalog.search(_query);
      if (!mounted || id != _requestId) return;
      setState(() {
        _results = results;
        _searched = true;
      });
    } catch (error) {
      if (!mounted || id != _requestId) return;
      setState(
        () => _error = error is CatalogException
            ? error.message
            : 'Não foi possível buscar. Tente novamente.',
      );
    } finally {
      if (mounted && id == _requestId) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar no catálogo')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  child: TextField(
                    controller: _controller,
                    autofocus: widget.dependencies.catalog.isConfigured,
                    onChanged: _onChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _debounce?.cancel();
                      _search();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Filmes ou séries',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                Expanded(child: _content()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    if (!widget.dependencies.catalog.isConfigured) {
      return const _CenteredMessage(
        icon: Icons.settings_outlined,
        message:
            'Catálogo pendente: configure TMDB_READ_ACCESS_TOKEN em config/local.json.',
      );
    }
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return _CenteredMessage(
        icon: Icons.wifi_off_rounded,
        message: _error!,
        action: TextButton(
          onPressed: _search,
          child: const Text('Tentar novamente'),
        ),
      );
    }
    if (_query.length < 2) {
      return const _CenteredMessage(
        icon: Icons.search_rounded,
        message: 'Digite pelo menos 2 caracteres para buscar.',
      );
    }
    if (_searched && _results.isEmpty) {
      return const _CenteredMessage(
        icon: Icons.movie_filter_outlined,
        message: 'Nenhum filme ou série encontrado.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: _results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final media = _results[index];
        return Card(
          color: AppColors.surface,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => MediaDetailPage(
                  media: media,
                  dependencies: widget.dependencies,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 64,
                      height: 92,
                      child: MediaArtwork(
                        url: media.posterUrl,
                        iconSize: 28,
                        semanticLabel: 'Pôster de ${media.title}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          media.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${media.year} • ${media.typeLabel}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'TMDB ${media.voteAverage.toStringAsFixed(1)}/10',
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  WatchlistButton(
                    key: ValueKey(media.mediaKey),
                    media: media,
                    repository: widget.dependencies.watchlist,
                    compact: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 44, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          if (action != null) ...[const SizedBox(height: 12), action!],
        ],
      ),
    ),
  );
}
