import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_brew_tracker/core/providers.dart';
import 'package:coffee_brew_tracker/core/database/database_provider.dart';
import 'package:coffee_brew_tracker/features/export/domain/export_service.dart';
import 'package:coffee_brew_tracker/core/widgets/section_header.dart';
import 'package:coffee_brew_tracker/features/history/presentation/controllers/history_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionHeader(title: 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (val) {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
          
          const Divider(height: 32),
          const SectionHeader(title: 'Data & Export'),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Export your brew logs to analyze or train models.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.table_chart),
            title: const Text('Export as CSV'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _exportCsv(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.data_object),
            title: const Text('Export as JSON'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _exportJson(context, ref),
          ),

          const Divider(height: 32),
          const SectionHeader(title: 'Danger Zone'),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
            title: Text('Wipe All Data', style: TextStyle(color: Theme.of(context).colorScheme.error)),
            onTap: () => _confirmWipeData(context, ref),
          ),

          const Divider(height: 32),
          const SectionHeader(title: 'About'),
          const ListTile(
            title: Text('Version 1.0.0'),
            subtitle: Text('Offline-first coffee tracking.'),
          )
        ],
      ),
    );
  }

  void _confirmWipeData(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Wipe All Data?'),
        content: const Text('This will permanently delete all your brew history. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(historyControllerProvider.notifier).clearAllBrews();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data wiped.')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  void _exportCsv(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(databaseProvider);
      final exportService = ExportService(db);
      await exportService.exportDataAsCsv();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  void _exportJson(BuildContext context, WidgetRef ref) async {
    try {
      final db = ref.read(databaseProvider);
      final exportService = ExportService(db);
      await exportService.exportDataAsJson();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }
}
