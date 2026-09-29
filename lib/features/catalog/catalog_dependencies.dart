import 'data/repositories/catalog_repository.dart';
import 'data/repositories/rating_repository.dart';
import 'data/repositories/watchlist_repository.dart';

class CatalogDependencies {
  const CatalogDependencies({
    required this.catalog,
    required this.watchlist,
    required this.ratings,
  });

  final CatalogRepository catalog;
  final WatchlistRepository watchlist;
  final RatingRepository ratings;
}
