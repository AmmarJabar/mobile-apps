import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_brew_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:coffee_brew_tracker/features/brew_log/presentation/screens/brew_log_screen.dart';
import 'package:coffee_brew_tracker/features/history/presentation/screens/history_screen.dart';
import 'package:coffee_brew_tracker/features/history/presentation/screens/brew_detail_screen.dart';
import 'package:coffee_brew_tracker/features/insights/presentation/screens/insights_screen.dart';
import 'package:coffee_brew_tracker/features/settings/presentation/screens/settings_screen.dart';
import 'package:coffee_brew_tracker/features/brew_log/domain/entities/brew_entity.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/log',
      builder: (context, state) => const BrewLogScreen(),
    ),
    GoRoute(
      path: '/brew-detail',
      builder: (context, state) {
        final brew = state.extra as BrewEntity;
        return BrewDetailScreen(brew: brew);
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/insights',
          builder: (context, state) => const InsightsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.uri.path;
    
    int currentIndex = _calculateSelectedIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(String location) {
    if (location.startsWith('/history')) return 1;
    if (location.startsWith('/insights')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0; // index 0 is Home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/insights');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }
}
