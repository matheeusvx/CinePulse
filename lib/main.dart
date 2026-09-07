import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/app_shell.dart';

void main() {
  runApp(const CinePulseApp());
}

class CinePulseApp extends StatelessWidget {
  const CinePulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinePulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const AppShell(),
    );
  }
}
