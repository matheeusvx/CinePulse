import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MediaArtwork extends StatelessWidget {
  const MediaArtwork({
    super.key,
    required this.url,
    this.iconSize = 36,
    this.semanticLabel,
  });

  final Uri? url;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    if (imageUrl == null) return _fallback();
    return Image.network(
      imageUrl.toString(),
      fit: BoxFit.cover,
      semanticLabel: semanticLabel,
      errorBuilder: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() => Semantics(
    label: semanticLabel ?? 'Imagem indisponível',
    image: true,
    child: Container(
      color: AppColors.surfaceStrong,
      alignment: Alignment.center,
      child: Icon(
        Icons.movie_outlined,
        size: iconSize,
        color: AppColors.textSecondary,
      ),
    ),
  );
}
