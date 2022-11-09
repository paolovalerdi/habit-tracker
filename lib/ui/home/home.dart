import 'package:flutter/material.dart';
import 'package:habit_tracker/data/providers.dart';
import 'package:habit_tracker/ui/add_habit_page.dart';
import 'package:habit_tracker/ui/habit_card.dart';
import 'package:habit_tracker/ui/home/toolbar.dart';
import 'package:habit_tracker/ui/tip_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const Toolbar(title: Text('Hábitos')),
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
                Icons.sentiment_satisfied_alt_rounded,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Comienza a crear hábitos',
                textAlign: TextAlign.center,
                style: styles.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Checa sstos consejos te podrían ayudar a comenzar",
                textAlign: TextAlign.center,
                style: styles.bodyText1
              ),
              const SizedBox(height: 24),
              TipCard(
                tips: [
                  "Recuerda que hacer ejercicio estimula tu mente y ayuda a oxigenar el cerebro",
                  "Tomar descansos de 5 minutos después de una hora de trabajo puede ayudar a mantener tu concentración",
                  "Realizar ejercicios de respiración pueden ayudar a mantener tu ritmo cardiaco, controlar los nervios y estimular la circulación de la sangre",
                  "El realizar ejercicio con pesas ayuda a crear resistencia al azúcar y así evitar antojos",
                  "Lo más importante al perder peso es un buen descanso, ya que se ha demostrado que mientras mas es el tiempo de descanso se reduce el hambre el estrés y mejora el estado de animo"
                  'Now that you have established a specific goal, it’s time to think about what will cue you to follow through. Scientists have proven that you’ll make more progress toward your goal if you decide not just what you’ll do, but when you’ll be cued to do it, as well as where you’ll do it and how you’ll get there.',
                  "When we set out to build a new habit, most of us overestimate our willpower and set a course for the most efficient path to achieving our end goal. Say you hope to get fit by exercising regularly – you’ll likely look for a workout that can generate quick results like grinding it out on a treadmill. But research has shown you’ll persist longer and ultimately achieve more if you instead focus on finding ways to make goal pursuit fun.",
                  "By the time we put a behavior on autopilot, a lot of us fall into fairly consistent routines, tending to exercise, study or take our medication at the same time of day and in the same place. But when you’re in the start-up phase of habit building, contrary to popular opinion, my research suggests it’s important to deliberately insert some variability into your routine.",
                ],
              ),
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
