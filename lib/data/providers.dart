import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/data/habit.dart';

class HabitsStateNotifier extends StateNotifier<List<Habit>> {
  HabitsStateNotifier() : super(const []);

  static final provider = StateNotifierProvider<HabitsStateNotifier, List<Habit>>(
    (ref) {
      return HabitsStateNotifier();
    },
  );

  void add(Habit habit) {
    state = [...state, habit];
  }
}
