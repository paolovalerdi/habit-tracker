import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TipCard extends HookWidget {
  const TipCard({
    Key? key,
    required this.tips,
  }) : super(key: key);

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    assert(tips.isNotEmpty, 'The tips list should not be empty');
    final styles = Theme.of(context).textTheme;
    final currentTip = useState(0);

    return GestureDetector(
      onTap: () {
        var next = currentTip.value + 1;
        if (next > tips.length - 1) next = 0;
        currentTip.value = next;
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Colors.yellow.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.lightbulb_rounded, color: Colors.black),
                  const Spacer(),
                  _Indicator(
                    radius: 3,
                    steps: tips.length,
                    currentStep: currentTip.value,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tips[currentTip.value],
                style: styles.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.radius,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  final double radius;
  final int steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: [
        for (int i = 0; i < steps; i++)
          CircleAvatar(
            radius: radius,
            backgroundColor: Colors.black.withOpacity(
              i == currentStep ? 1 : 0.2,
            ),
          ),
      ],
    );
  }
}
