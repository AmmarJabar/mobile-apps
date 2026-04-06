import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_brew_tracker/features/history/presentation/controllers/history_controller.dart';
import 'package:coffee_brew_tracker/features/history/presentation/widgets/brew_list_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh history when home screen is returned to
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyControllerProvider.notifier).loadBrews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyControllerProvider);
    final recentBrews = state.brews.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kopitology'),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart),
            onPressed: () => context.go('/insights'),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(historyControllerProvider.notifier).loadBrews(),
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildWelcomeCard(context),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Brews',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () => context.go('/history'),
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (recentBrews.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(Icons.coffee_maker_outlined,
                                size: 48,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant),
                            const SizedBox(height: 16),
                            Text('No brews logged yet.',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                    )
                  else
                    ...recentBrews.map((brew) => BrewListItem(
                          brew: brew,
                          onDelete: () {
                            ref
                                .read(historyControllerProvider.notifier)
                                .deleteBrew(brew.id!);
                          },
                          onTap: () {
                            context.push('/brew-detail', extra: brew);
                          },
                        )),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/log'),
        icon: const Icon(Icons.add),
        label: const Text('Log Brew'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 1.1, // Zoom factor
              child: Image.asset(
                'assets/images/coffeebrew.jpg',
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, 1.3),
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to brew?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your recipes, analyze your data, and perfect your cup.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
