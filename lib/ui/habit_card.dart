import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:intl/intl.dart';

class HabitCard extends StatelessWidget implements PreferredSizeWidget {
  const HabitCard(
    this.habit, {
    Key? key,
  }) : super(key: key);

  final Habit habit;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = theme.textTheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: CustomPaint(
        painter: _Painter(habit.color),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                habit.icon,
                size: 24,
                color: Colors.white.withOpacity(0.8),
              ),
              const Spacer(),
              Text(
                habit.title,
                style: styles.headline6
                    ?.copyWith(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${DateFormat.yMMMEd().format(habit.startDate)}',
                style: styles.caption?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = color,
    );
    canvas.drawCircle(
      Offset(0, size.height / 2),
      size.width * 0.65,
      Paint()..color = darken(color, 0.035),
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}
