import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../catalog/catalog_dependencies.dart';
import '../../catalog/data/models/watchlist_entry.dart';
import '../../catalog/presentation/media_detail_page.dart';
import '../../catalog/presentation/widgets/media_artwork.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key, this.dependencies});
  final CatalogDependencies? dependencies;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<WatchlistEntry>>(
    stream: dependencies?.watchlist.watchAll(),
    builder: (context, snapshot) {
      final entries = snapshot.data ?? const <WatchlistEntry>[];
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Listas',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            'Títulos que você quer assistir.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Quero assistir',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  '${entries.length} itens',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (dependencies != null &&
              snapshot.connectionState == ConnectionState.waiting)
            const Center(child: CircularProgressIndicator())
          else if (snapshot.hasError)
            const Text(
              'Não foi possível carregar a Watchlist. Verifique a conexão e tente novamente.',
            )
          else if (entries.isEmpty)
            const Text(
              'Sua Watchlist está vazia. Explore o catálogo para adicionar títulos.',
            )
          else
            for (final entry in entries)
              Card(
                color: AppColors.surface,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => MediaDetailPage(
                        media: entry.media,
                        dependencies: dependencies!,
                      ),
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                      width: 42,
                      height: 62,
                      child: MediaArtwork(url: entry.media.posterUrl),
                    ),
                  ),
                  title: Text(
                    entry.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${entry.media.typeLabel} • ${entry.media.year}',
                  ),
                  trailing: IconButton(
                    tooltip: 'Remover da Watchlist',
                    icon: const Icon(Icons.bookmark_remove_outlined),
                    onPressed: () async {
                      try {
                        await dependencies!.watchlist.remove(entry.mediaKey);
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Não foi possível remover o título.',
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
        ],
      );
    },
  );
}
