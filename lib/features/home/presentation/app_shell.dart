import 'package:flutter/material.dart';

import '../../diary/presentation/diary_page.dart';
import '../../lists/presentation/lists_page.dart';
import '../../profile/presentation/profile_page.dart';
import 'home_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _pages = [
    HomePage(),
    DiaryPage(),
    ListsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final isWide = MediaQuery.sizeOf(context).width >= 760;
        final content = Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        );

        return Scaffold(
          body: SafeArea(
            child: Row(
            children: [
              SizedBox(
                width: isWide ? 88 : 0,
                child: isWide
                    ? _DesktopNavigation(
                        selectedIndex: _currentIndex,
                        onDestinationSelected: _selectPage,
                      )
                    : null,
              ),
              SizedBox(
                width: isWide ? 1 : 0,
                child: isWide
                    ? const VerticalDivider(width: 1, thickness: 1)
                    : null,
              ),
              Expanded(child: content),
            ],
            ),
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _selectPage,
                  destinations: _destinations,
                ),
        );
      },
    );
  }

  void _selectPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.explore_outlined),
      selectedIcon: Icon(Icons.explore_rounded),
      label: 'Descobrir',
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_month_outlined),
      selectedIcon: Icon(Icons.calendar_month_rounded),
      label: 'Diário',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmarks_outlined),
      selectedIcon: Icon(Icons.bookmarks_rounded),
      label: 'Listas',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Perfil',
    ),
  ];
}

class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      groupAlignment: -0.8,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0, 18, 0, 36),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.play_arrow_rounded, color: Colors.white),
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: Text('Descobrir'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month_rounded),
          label: Text('Diário'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmarks_outlined),
          selectedIcon: Icon(Icons.bookmarks_rounded),
          label: Text('Listas'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: Text('Perfil'),
        ),
      ],
    );
  }
}
