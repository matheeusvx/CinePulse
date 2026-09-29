import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/mood_tag.dart';
import '../../data/models/rating_entry.dart';

class RatingSheet extends StatefulWidget {
  const RatingSheet({super.key, this.initial});

  final RatingEntry? initial;

  @override
  State<RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<RatingSheet> {
  double? _rating;
  late final TextEditingController _review;
  late final Set<MoodTag> _moods;
  late bool _spoiler;
  late final Map<String, double?> _scores;

  @override
  void initState() {
    super.initState();
    final entry = widget.initial;
    _rating = entry?.rating;
    _review = TextEditingController(text: entry?.reviewText ?? '');
    _moods = {...?entry?.moodTags};
    _spoiler = entry?.containsSpoiler ?? false;
    _scores = {
      'História': entry?.pulseScore?.story,
      'Atuação': entry?.pulseScore?.acting,
      'Visual': entry?.pulseScore?.visual,
      'Trilha': entry?.pulseScore?.soundtrack,
    };
  }

  @override
  void dispose() {
    _review.dispose();
    super.dispose();
  }

  void _toggleMood(MoodTag mood) {
    setState(() {
      if (_moods.contains(mood)) {
        _moods.remove(mood);
      } else if (_moods.length < 3) {
        _moods.add(mood);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Escolha até 3 MoodTags.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Marcar como assistido',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nota geral obrigatória, de 0.5 a 5.0.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (var halfStars = 1; halfStars <= 10; halfStars++)
                        ChoiceChip(
                          label: Text((halfStars / 2).toStringAsFixed(1)),
                          selected: _rating == halfStars / 2,
                          onSelected: (_) =>
                              setState(() => _rating = halfStars / 2),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'MoodTags (até 3)',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final mood in MoodTag.values)
                        FilterChip(
                          label: Text(mood.label),
                          selected: _moods.contains(mood),
                          onSelected: (_) => _toggleMood(mood),
                        ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Detalhar PulseScore'),
                    tilePadding: EdgeInsets.zero,
                    children: [
                      for (final label in _scores.keys)
                        Row(
                          children: [
                            SizedBox(width: 70, child: Text(label)),
                            Expanded(
                              child: Slider(
                                value: _scores[label] ?? 0.5,
                                min: 0.5,
                                max: 5,
                                divisions: 9,
                                label:
                                    _scores[label]?.toStringAsFixed(1) ??
                                    'Não definido',
                                onChanged: (value) =>
                                    setState(() => _scores[label] = value),
                              ),
                            ),
                            TextButton(
                              onPressed: _scores[label] == null
                                  ? null
                                  : () => setState(() => _scores[label] = null),
                              child: Text(
                                _scores[label]?.toStringAsFixed(1) ?? '—',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  TextField(
                    controller: _review,
                    maxLength: 2000,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Sua review (opcional)',
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Contém spoiler'),
                    value: _spoiler,
                    onChanged: (value) => setState(() => _spoiler = value),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            FilledButton(
              onPressed: _rating == null
                  ? null
                  : () => Navigator.of(context).pop(
                      RatingDraft(
                        rating: _rating!,
                        moodTags: _moods.toList(),
                        reviewText: _review.text,
                        containsSpoiler: _spoiler,
                        pulseScore: PulseScore(
                          story: _scores['História'],
                          acting: _scores['Atuação'],
                          visual: _scores['Visual'],
                          soundtrack: _scores['Trilha'],
                        ),
                      ),
                    ),
              child: const Text('Salvar avaliação'),
            ),
          ],
        ),
      ),
    ),
  );
}
