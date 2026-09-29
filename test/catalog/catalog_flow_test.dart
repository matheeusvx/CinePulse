import 'dart:async';

import 'package:cinepulse/core/theme/app_theme.dart';
import 'package:cinepulse/features/catalog/catalog_dependencies.dart';
import 'package:cinepulse/features/catalog/data/models/media_item.dart';
import 'package:cinepulse/features/catalog/data/models/mood_tag.dart';
import 'package:cinepulse/features/catalog/data/models/rating_entry.dart';
import 'package:cinepulse/features/catalog/data/models/watchlist_entry.dart';
import 'package:cinepulse/features/catalog/data/repositories/catalog_repository.dart';
import 'package:cinepulse/features/catalog/data/repositories/rating_repository.dart';
import 'package:cinepulse/features/catalog/data/repositories/watchlist_repository.dart';
import 'package:cinepulse/features/catalog/presentation/search_page.dart';
import 'package:cinepulse/features/home/presentation/home_page.dart';
import 'package:cinepulse/features/diary/presentation/diary_page.dart';
import 'package:cinepulse/features/lists/presentation/lists_page.dart';
import 'package:cinepulse/features/profile/presentation/profile_page.dart';
import 'package:cinepulse/features/profile/data/models/profile.dart';
import 'package:cinepulse/features/profile/data/repositories/profile_repository.dart';
import 'package:cinepulse/features/catalog/presentation/widgets/personal_review_card.dart';
import 'package:cinepulse/features/catalog/presentation/widgets/rating_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Future<List<MediaItem>> trending() async => [_media];

  @override
  Future<List<MediaItem>> byMood(MoodTag mood) async => [_media];
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
  Stream<List<WatchlistEntry>> watchAll() async* {
    List<WatchlistEntry> snapshot() => [
      for (final key in items)
        WatchlistEntry(
          mediaKey: key,
          tmdbId: _media.tmdbId,
          mediaType: _media.mediaType,
          title: _media.title,
          posterPath: null,
          releaseDate: _media.releaseDate,
          addedAt: DateTime.now(),
        ),
    ];
    yield snapshot();
    yield* _changes.stream.map((_) => snapshot());
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
  final drafts = <String, RatingDraft>{};
  final _changes = StreamController<void>.broadcast(sync: true);

  @override
  Future<double?> getRating(String mediaKey) async => ratings[mediaKey];

  @override
  Future<RatingEntry?> getEntry(String mediaKey) async {
    final rating = ratings[mediaKey];
    final draft = drafts[mediaKey];
    return rating == null
        ? null
        : RatingEntry(
            mediaKey: mediaKey,
            tmdbId: _media.tmdbId,
            mediaType: _media.mediaType,
            title: _media.title,
            posterPath: null,
            rating: rating,
            watchedAt: DateTime.now(),
            updatedAt: DateTime.now(),
            moodTags: draft?.moodTags ?? const [],
            reviewText: draft?.reviewText ?? '',
            containsSpoiler: draft?.containsSpoiler ?? false,
            pulseScore: draft?.pulseScore,
          );
  }

  @override
  Stream<List<RatingEntry>> watchAll() async* {
    Future<List<RatingEntry>> snapshot() async => [
      for (final key in ratings.keys) (await getEntry(key))!,
    ];
    yield await snapshot();
    await for (final _ in _changes.stream) {
      yield await snapshot();
    }
  }

  @override
  Future<void> save(MediaItem media, RatingDraft draft) async {
    ratings[media.mediaKey] = draft.rating;
    drafts[media.mediaKey] = draft;
    await watchlist.remove(media.mediaKey);
    _changes.add(null);
  }

  @override
  Future<void> delete(String mediaKey) async {
    ratings.remove(mediaKey);
    drafts.remove(mediaKey);
    _changes.add(null);
  }

  Future<void> dispose() => _changes.close();
}

class FakeProfileRepository implements ProfileDataRepository {
  @override
  String? get currentEmail => 'usuario@cinepulse.com';

  @override
  Stream<Profile?> watchMine() => Stream.value(
    const Profile(
      id: 'user',
      displayName: 'Nome real',
      username: 'nome.real',
      createdAt: null,
      updatedAt: null,
    ),
  );
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
      profile: FakeProfileRepository(),
    );
  });

  tearDown(() async {
    await watchlist.dispose();
    await ratings.dispose();
  });

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

  testWidgets('Home mostra mídia real do catálogo e abre detalhe', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: HomePage(catalogDependencies: dependencies)),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Em alta no TMDB'),
      280,
      scrollable: find
          .descendant(
            of: find.byType(HomePage),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    expect(find.text('Em alta no TMDB'), findsOneWidget);
    expect(find.byKey(const Key('media-movie_10')), findsWidgets);
    await tester.tap(find.byKey(const Key('media-movie_10')).first);
    await tester.pumpAndSettle();
    expect(find.text('Sinopse de teste.'), findsOneWidget);
  });

  testWidgets('Diário mostra registro, permite editar e excluir', (
    tester,
  ) async {
    await ratings.save(_media, RatingDraft(rating: 4));
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: DiaryPage(dependencies: dependencies)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Filme teste'), findsOneWidget);
    expect(find.text('1', skipOffstage: false), findsWidgets);
    await tester.tap(find.byTooltip('Ações da avaliação'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar avaliação'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '4.5'));
    await tester.tap(find.text('Salvar avaliação'));
    await tester.pumpAndSettle();
    expect(ratings.ratings[_media.mediaKey], 4.5);
    await tester.tap(find.byTooltip('Ações da avaliação'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Excluir avaliação'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    expect(ratings.ratings, isEmpty);
    expect(find.textContaining('Seu diário começa'), findsOneWidget);
  });

  testWidgets('Watchlist usa registros reais e remove item', (tester) async {
    await watchlist.add(_media);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: ListsPage(dependencies: dependencies)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('1 itens'), findsOneWidget);
    expect(find.text('Filme teste'), findsOneWidget);
    await tester.tap(find.byTooltip('Remover da Watchlist'));
    await tester.pumpAndSettle();
    expect(watchlist.items, isEmpty);
    expect(find.text('0 itens'), findsOneWidget);
  });

  test('MoodTags limitadas a 3 e campos opcionais', () {
    expect(
      () => RatingDraft(rating: 4, moodTags: MoodTag.values.take(4).toList()),
      throwsArgumentError,
    );
    expect(RatingDraft(rating: 4).reviewText, isEmpty);
    expect(
      () => RatingDraft(rating: 4, reviewText: 'a' * 2001),
      throwsArgumentError,
    );
    expect(
      () => RatingDraft(rating: 4, pulseScore: const PulseScore(story: 5.1)),
      throwsArgumentError,
    );
  });

  test('documento de avaliação da Etapa 2 continua legível', () {
    final entry = RatingEntry.fromFirestore('movie_10', {
      'tmdbId': 10,
      'mediaType': 'movie',
      'title': 'Filme teste',
      'posterPath': null,
      'rating': 4.5,
      'watchedAt': Timestamp.fromDate(DateTime(2025, 1, 1)),
      'updatedAt': Timestamp.fromDate(DateTime(2025, 1, 1)),
    });
    expect(entry.rating, 4.5);
    expect(entry.moodTags, isEmpty);
    expect(entry.reviewText, isEmpty);
    expect(entry.containsSpoiler, isFalse);
    expect(entry.pulseScore, isNull);
  });

  testWidgets('folha de avaliação limita seleção a três MoodTags', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const Scaffold(body: RatingSheet()),
      ),
    );
    await tester.pumpAndSettle();
    for (final mood in MoodTag.values.take(4)) {
      await tester.tap(find.widgetWithText(FilterChip, mood.label));
      await tester.pump();
    }
    final chips = tester.widgetList<FilterChip>(find.byType(FilterChip));
    expect(chips.where((chip) => chip.selected).length, 3);
  });

  testWidgets('review com spoiler inicia fechada e revela somente o card', (
    tester,
  ) async {
    final entry = RatingEntry(
      mediaKey: 'movie_10',
      tmdbId: 10,
      mediaType: MediaType.movie,
      title: 'Filme teste',
      posterPath: null,
      rating: 4,
      watchedAt: DateTime(2025),
      updatedAt: DateTime(2025),
      reviewText: 'Segredo do final',
      containsSpoiler: true,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              PersonalReviewCard(entry: entry),
              PersonalReviewCard(entry: entry, heading: 'Outra review'),
            ],
          ),
        ),
      ),
    );
    expect(find.text('Segredo do final'), findsNothing);
    await tester.tap(find.text('Revelar spoiler').first);
    await tester.pump();
    expect(find.text('Segredo do final'), findsOneWidget);
    expect(find.text('Revelar spoiler'), findsOneWidget);
  });

  testWidgets('Perfil mostra métricas e review reais', (tester) async {
    await watchlist.add(_media);
    await ratings.save(
      _media,
      RatingDraft(
        rating: 4.5,
        moodTags: [MoodTag.leve],
        reviewText: 'Gostei muito',
      ),
    );
    await watchlist.add(_media);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: ProfilePage(onSignOut: () async {}, dependencies: dependencies),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Nome real'), findsOneWidget);
    expect(find.text('@nome.real'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('Leve • 1'), findsOneWidget);
    expect(find.text('Gostei muito'), findsOneWidget);
  });
}
