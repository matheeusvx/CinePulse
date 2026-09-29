import 'dart:async';

import 'package:cinepulse/core/theme/app_theme.dart';
import 'package:cinepulse/features/catalog/catalog_dependencies.dart';
import 'package:cinepulse/features/catalog/data/models/media_item.dart';
import 'package:cinepulse/features/catalog/data/repositories/catalog_repository.dart';
import 'package:cinepulse/features/catalog/data/repositories/rating_repository.dart';
import 'package:cinepulse/features/catalog/data/repositories/watchlist_repository.dart';
import 'package:cinepulse/features/catalog/presentation/search_page.dart';
import 'package:cinepulse/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _media = MediaItem(
  tmdbId: 10,
  mediaType: MediaType.movie,
  title: 'Filme teste',
  overview: 'Sinopse de teste.',
  posterPath: null,
  backdropPath: null,
  releaseDate: '2024-01-01',
  voteAverage: 8.2,
  genreIds: [18],
  genres: ['Drama'],
  runtimeMinutes: 120,
);

class FakeCatalogRepository implements CatalogRepository {
  FakeCatalogRepository({this.configured = true});

  final bool configured;
  int searches = 0;

  @override
  bool get isConfigured => configured;

  @override
  Future<List<MediaItem>> search(String query) async {
    searches++;
    return [_media];
  }

  @override
  Future<MediaItem> getDetails(MediaType type, int tmdbId) async => _media;
}

class FakeWatchlistRepository implements WatchlistRepository {
  final items = <String>{};
  final _changes = StreamController<String>.broadcast(sync: true);

  @override
  Future<bool> contains(String mediaKey) async => items.contains(mediaKey);

  @override
  Stream<bool> watch(String mediaKey) async* {
    yield items.contains(mediaKey);
    yield* _changes.stream
        .where((key) => key == mediaKey)
        .map((_) => items.contains(mediaKey));
  }

  @override
  Future<void> add(MediaItem media) async {
    items.add(media.mediaKey);
    _changes.add(media.mediaKey);
  }

  @override
  Future<void> remove(String mediaKey) async {
    items.remove(mediaKey);
    _changes.add(mediaKey);
  }

  @override
  Future<void> toggle(MediaItem media) async {
    if (items.contains(media.mediaKey)) {
      await remove(media.mediaKey);
    } else {
      await add(media);
    }
  }

  Future<void> dispose() => _changes.close();
}

class FakeRatingRepository implements RatingRepository {
  FakeRatingRepository(this.watchlist);

  final FakeWatchlistRepository watchlist;
  final ratings = <String, double>{};

  @override
  Future<double?> getRating(String mediaKey) async => ratings[mediaKey];

  @override
  Future<void> save(MediaItem media, double rating) async {
    ratings[media.mediaKey] = rating;
    await watchlist.remove(media.mediaKey);
  }
}

void main() {
  late FakeCatalogRepository catalog;
  late FakeWatchlistRepository watchlist;
  late FakeRatingRepository ratings;
  late CatalogDependencies dependencies;

  setUp(() {
    catalog = FakeCatalogRepository();
    watchlist = FakeWatchlistRepository();
    ratings = FakeRatingRepository(watchlist);
    dependencies = CatalogDependencies(
      catalog: catalog,
      watchlist: watchlist,
      ratings: ratings,
    );
  });

  tearDown(() async => watchlist.dispose());

  Future<void> openSearch(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: SearchPage(dependencies: dependencies),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Filme');
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();
  }

  testWidgets('busca usa debounce e renderiza resultado', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: SearchPage(dependencies: dependencies),
      ),
    );
    await tester.enterText(find.byType(TextField), 'F');
    await tester.pump(const Duration(milliseconds: 500));
    expect(catalog.searches, 0);
    await tester.enterText(find.byType(TextField), 'Fi');
    await tester.pump(const Duration(milliseconds: 200));
    await tester.enterText(find.byType(TextField), 'Filme');
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();

    expect(catalog.searches, 1);
    expect(find.text('Filme teste'), findsOneWidget);
    expect(find.text('2024 • Filme'), findsOneWidget);
    await tester.tap(find.byTooltip('Adicionar à Watchlist'));
    await tester.pumpAndSettle();
    expect(watchlist.items, contains('movie_10'));
    expect(find.text('Buscar no catálogo'), findsOneWidget);
  });

  testWidgets('campo da Home abre a busca real', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: HomePage(catalogDependencies: dependencies)),
      ),
    );
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(find.text('Buscar no catálogo'), findsOneWidget);
  });

  testWidgets('sem token mostra configuração pendente sem fazer busca', (
    tester,
  ) async {
    catalog = FakeCatalogRepository(configured: false);
    dependencies = CatalogDependencies(
      catalog: catalog,
      watchlist: watchlist,
      ratings: ratings,
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: SearchPage(dependencies: dependencies),
      ),
    );
    expect(find.textContaining('TMDB_READ_ACCESS_TOKEN'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Filme teste');
    await tester.pump(const Duration(milliseconds: 500));
    expect(catalog.searches, 0);
  });

  testWidgets('abre detalhe, alterna Watchlist e salva/atualiza avaliação', (
    tester,
  ) async {
    await openSearch(tester);
    await tester.tap(find.text('Filme teste'));
    await tester.pumpAndSettle();
    expect(find.text('Sinopse de teste.'), findsOneWidget);
    expect(find.text('120 min'), findsOneWidget);

    await tester.ensureVisible(find.text('Adicionar à Watchlist'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Adicionar à Watchlist'));
    await tester.pumpAndSettle();
    expect(watchlist.items, contains('movie_10'));
    expect(find.text('Remover da Watchlist'), findsOneWidget);

    await tester.tap(find.text('Assistido / Avaliar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '4.5'));
    await tester.pump();
    await tester.tap(find.text('Salvar avaliação'));
    await tester.pumpAndSettle();
    expect(ratings.ratings['movie_10'], 4.5);
    expect(watchlist.items, isEmpty);
    expect(find.text('Adicionar à Watchlist'), findsOneWidget);

    await tester.ensureVisible(find.text('Sua nota: 4.5 • Alterar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sua nota: 4.5 • Alterar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '5.0'));
    await tester.pump();
    await tester.tap(find.text('Salvar avaliação'));
    await tester.pumpAndSettle();
    expect(ratings.ratings['movie_10'], 5.0);
  });
}
