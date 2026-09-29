import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/media_item.dart';
import '../../data/repositories/watchlist_repository.dart';

class WatchlistButton extends StatefulWidget {
  const WatchlistButton({
    super.key,
    required this.media,
    required this.repository,
    this.compact = false,
  });

  final MediaItem media;
  final WatchlistRepository repository;
  final bool compact;

  @override
  State<WatchlistButton> createState() => _WatchlistButtonState();
}

class _WatchlistButtonState extends State<WatchlistButton> {
  StreamSubscription<bool>? _subscription;
  bool _selected = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant WatchlistButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media.mediaKey != widget.media.mediaKey ||
        oldWidget.repository != widget.repository) {
      _subscription?.cancel();
      _selected = false;
      _subscribe();
    }
  }

  void _subscribe() {
    _subscription = widget.repository.watch(widget.media.mediaKey).listen((
      value,
    ) {
      if (mounted && !_busy) setState(() => _selected = value);
    }, onError: (_) {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_busy) return;
    final previous = _selected;
    final selected = !previous;
    setState(() {
      _selected = selected;
      _busy = true;
    });
    try {
      if (selected) {
        await widget.repository.add(widget.media);
      } else {
        await widget.repository.remove(widget.media.mediaKey);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _selected = previous);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível atualizar a Watchlist.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _selected ? 'Remover da Watchlist' : 'Adicionar à Watchlist';
    if (widget.compact) {
      return IconButton(
        tooltip: label,
        onPressed: _busy ? null : _toggle,
        icon: Icon(
          _selected ? Icons.bookmark_rounded : Icons.bookmark_add_outlined,
        ),
      );
    }
    return FilledButton.tonalIcon(
      onPressed: _busy ? null : _toggle,
      icon: Icon(
        _selected ? Icons.bookmark_rounded : Icons.bookmark_add_outlined,
      ),
      label: Text(label),
    );
  }
}
