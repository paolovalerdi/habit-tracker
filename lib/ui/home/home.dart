import 'package:flutter/material.dart';
import 'package:habit_tracker/data/providers.dart';
import 'package:habit_tracker/ui/add_habit_page.dart';
import 'package:habit_tracker/ui/habit_card.dart';
import 'package:habit_tracker/ui/home/toolbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const Toolbar(title: Text('Home')),
      body: const _HabitsGrid(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add_rounded),
        onPressed: () => AddHabitPage.open(context),
      ),
    );
  }
}

class _HabitsGrid extends HookConsumerWidget {
  const _HabitsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.of(context).padding;
    final habits = ref.watch(HabitsStateNotifier.provider);

    if (habits.isEmpty) {
      final styles = Theme.of(context).textTheme;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sentiment_dissatisfied_rounded,
                size: 64,
              ),
              const SizedBox(height: 8),
              Text(
                'Start creating new habits',
                style: styles.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      itemCount: habits.length,
      padding: EdgeInsets.fromLTRB(
        16,
        padding.top + 16,
        16,
        padding.bottom + 16,
      ),
      itemBuilder: (context, index) => HabitCard(habits[index]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 11,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
    );
  }
}
