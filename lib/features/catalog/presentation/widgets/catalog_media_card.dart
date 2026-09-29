import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../catalog_dependencies.dart';
import '../../data/models/media_item.dart';
import '../media_detail_page.dart';
import 'media_artwork.dart';

class CatalogMediaCard extends StatelessWidget {
  const CatalogMediaCard({
    super.key,
    required this.media,
    required this.dependencies,
  });

  final MediaItem media;
  final CatalogDependencies dependencies;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 150,
    child: InkWell(
      key: Key('media-${media.mediaKey}'),
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              MediaDetailPage(media: media, dependencies: dependencies),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 212,
              width: 150,
              child: MediaArtwork(
                url: media.posterUrl,
                semanticLabel: 'Pôster de ${media.title}',
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            media.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            '${media.typeLabel} • TMDB ${media.voteAverage.toStringAsFixed(1)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}
