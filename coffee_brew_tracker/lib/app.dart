import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_brew_tracker/core/theme/app_theme.dart';
import 'package:coffee_brew_tracker/core/providers.dart';
import 'package:coffee_brew_tracker/navigation/app_router.dart';

class BrewLogApp extends ConsumerWidget {
  const BrewLogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Kopitology',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
