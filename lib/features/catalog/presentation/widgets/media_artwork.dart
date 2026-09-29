import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MediaArtwork extends StatelessWidget {
  const MediaArtwork({super.key, required this.url, this.iconSize = 36});

  final Uri? url;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url;
    if (imageUrl == null) return _fallback();
    return Image.network(
      imageUrl.toString(),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() => Container(
    color: AppColors.surfaceStrong,
    alignment: Alignment.center,
    child: Icon(
      Icons.movie_outlined,
      size: iconSize,
      color: AppColors.textSecondary,
    ),
  );
}
