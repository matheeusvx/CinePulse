import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../catalog/catalog_dependencies.dart';
import '../../catalog/data/models/rating_entry.dart';
import '../../catalog/presentation/media_detail_page.dart';
import '../../catalog/presentation/widgets/media_artwork.dart';
import '../../catalog/presentation/widgets/rating_sheet.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, this.dependencies});
  final CatalogDependencies? dependencies;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late Stream<List<RatingEntry>>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = widget.dependencies?.ratings.watchAll();
  }

  void _retry() => setState(() {
    _stream = widget.dependencies?.ratings.watchAll();
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<RatingEntry>>(
    stream: _stream,
    builder: (context, snapshot) {
      final entries = snapshot.data ?? const <RatingEntry>[];
      final now = DateTime.now();
      final month = entries
          .where(
            (e) =>
                e.watchedAt?.year == now.year &&
                e.watchedAt?.month == now.month,
          )
          .length;
      final year = entries.where((e) => e.watchedAt?.year == now.year).length;
      final average = entries.isEmpty
          ? null
          : entries.map((e) => e.rating).reduce((a, b) => a + b) /
                entries.length;
      final groups = <String, List<RatingEntry>>{};
      for (final entry in entries) {
        final date = entry.watchedAt;
        final key = date == null
            ? 'Data indisponível'
            : '${_months[date.month - 1]} ${date.year}';
        groups.putIfAbsent(key, () => []).add(entry);
      }
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Diário',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          const Text(
            'Seu histórico de filmes e séries assistidos.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Stat(label: 'Neste mês', value: '$month'),
              const SizedBox(width: 8),
              _Stat(label: 'Neste ano', value: '$year'),
              const SizedBox(width: 8),
              _Stat(
                label: 'Nota média',
                value: average?.toStringAsFixed(1) ?? '—',
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (widget.dependencies != null &&
              snapshot.connectionState == ConnectionState.waiting)
            const Center(child: CircularProgressIndicator())
          else if (snapshot.hasError)
            Column(
              children: [
                const Text('Não foi possível carregar o diário.'),
                TextButton(
                  onPressed: _retry,
                  child: const Text('Tentar novamente'),
                ),
              ],
            )
          else if (entries.isEmpty)
            const Text(
              'Seu diário começa quando você avalia um filme ou série.',
            )
          else
            for (final group in groups.entries) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  group.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              for (final entry in group.value)
                _DiaryItem(entry: entry, dependencies: widget.dependencies!),
            ],
        ],
      );
    },
  );
}

const _months = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
];

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}

class _DiaryItem extends StatelessWidget {
  const _DiaryItem({required this.entry, required this.dependencies});
  final RatingEntry entry;
  final CatalogDependencies dependencies;

  Future<void> _edit(BuildContext context) async {
    final draft = await showModalBottomSheet<RatingDraft>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => RatingSheet(initial: entry),
    );
    if (draft == null || !context.mounted) return;
    try {
      await dependencies.ratings.save(entry.media, draft);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível salvar a avaliação.')),
        );
      }
    }
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir avaliação?'),
        content: Text('Remover ${entry.title} do Diário?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await dependencies.ratings.delete(entry.mediaKey);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível excluir a avaliação.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              MediaDetailPage(media: entry.media, dependencies: dependencies),
        ),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: SizedBox(
          width: 42,
          height: 62,
          child: MediaArtwork(
            url: entry.media.posterUrl,
            semanticLabel: 'Pôster de ${entry.title}',
          ),
        ),
      ),
      title: Text(
        entry.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        '${entry.media.typeLabel} • ${entry.watchedAt == null ? 'Data indisponível' : '${entry.watchedAt!.day}/${entry.watchedAt!.month}/${entry.watchedAt!.year}'} • ★ ${entry.rating.toStringAsFixed(1)}',
      ),
      trailing: PopupMenuButton<String>(
        tooltip: 'Ações da avaliação',
        onSelected: (action) =>
            action == 'edit' ? _edit(context) : _delete(context),
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'edit', child: Text('Editar avaliação')),
          PopupMenuItem(value: 'delete', child: Text('Excluir avaliação')),
        ],
      ),
    ),
  );
}
