import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/providers.dart';
import 'package:habit_tracker/ui/home/toolbar.dart';
import 'package:habit_tracker/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  static void open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddHabitPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: Toolbar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: Navigator.of(context).maybePop,
        ),
        title: const Text('Add'),
      ),
      body: _Content(),
    );
  }
}

class _Content extends HookConsumerWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentColor = useState(Colors.primaries.first.shade700);
    final currentIcon = useState(Icons.add);
    final enabled = useState(false);
    final padding = MediaQuery.of(context).padding;
    final style = Theme.of(context).textTheme;
    final title = useTextEditingController();
    final description = useTextEditingController();
    final startDate = useTextEditingController(
      text: 'Starting at: ${DateFormat.yMMMEd().format(DateTime.now())}',
    );
    final titleUpdate = useValueListenable(title);
    final descriptionUpdate = useValueListenable(description);

    useEffect(
      () {
        enabled.value = title.text.isNotEmpty && description.text.isNotEmpty;
        return;
      },
      [titleUpdate, descriptionUpdate],
    );

    return CustomScrollView(
      slivers: [
        SizedBox(height: padding.top).toSliver(),
        const Divider().toSliver(),
        TextField(
          controller: title,
          style: style.headline6?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Go to bed before 10 PM',
            hintStyle: style.headline6?.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ).toSliver(),
        const Divider().toSliver(),
        TextField(
          controller: description,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Description',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ).toSliver(),
        const Divider().toSliver(),
        TextField(
          controller: startDate,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Description',
            enabled: false,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ).toSliver(),
        const Divider().toSliver(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(
              List.from(
                [
                  const Icon(Icons.add),
                  const Icon(Icons.account_balance),
                  const Icon(Icons.accessibility_rounded),
                  const Icon(Icons.water_drop_rounded),
                  const Icon(Icons.access_time_filled_rounded),
                  const Icon(Icons.ac_unit),
                  const Icon(Icons.note_alt_rounded),
                  const Icon(Icons.wallet_rounded),
                  const Icon(Icons.camera_alt_rounded),
                  const Icon(Icons.lightbulb_rounded),
                  const Icon(Icons.cookie),
                  const Icon(Icons.calendar_month_rounded),
                  // Icon(Icons),
                ].map(
                  (it) {
                    if (currentIcon.value != it.icon) {
                      return InkWell(
                        child: it,
                        onTap: () => currentIcon.value = it.icon!,
                      );
                    }
                    ;
                    return CircleAvatar(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      child: it,
                    );
                  },
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.5,
              mainAxisSpacing: 16,
            ),
          ),
        ),
        const Divider().toSliver(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(
              List.from(
                Colors.primaries.map(
                  (it) => Card(
                    color: it.shade500,
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () => currentColor.value = it,
                      child: it == currentColor.value
                          ? Icon(
                              Icons.check_circle,
                              size: 20,
                              color: it.computeLuminance() >= .5
                                  ? Colors.black
                                  : Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            onPressed: enabled.value
                ? () {
                    ref.read(HabitsStateNotifier.provider.notifier).add(
                          Habit(
                            title: title.text,
                            description: description.text,
                            startDate: DateTime.now(),
                            color: currentColor.value,
                            icon: currentIcon.value,
                          ),
                        );
                    Navigator.of(context).maybePop();
                  }
                : null,
            child: const Text('Start'),
          ),
        ).toSliver(),
        SizedBox(height: padding.bottom + 16).toSliver(),
      ],
    );
  }
}
