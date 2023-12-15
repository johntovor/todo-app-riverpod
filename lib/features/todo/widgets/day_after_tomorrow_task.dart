import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/todo/todo_provider.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/update_task.dart';
import 'todo_tile.dart';

class DayAfterTomorrowTask extends ConsumerWidget {
  const DayAfterTomorrowTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    String dayAfterTomorrow =
        ref.read(todoStateProvider.notifier).getDayAfterTomorrow();
    var color = ref.read(todoStateProvider.notifier).getRandomColors();
    var dayAfterTomorrowTasks = todos.where(
      (element) => element.date!.contains(dayAfterTomorrow),
    );

    return XpansionTile(
      text: dayAfterTomorrow,
      text2: "Day after tomorrow's tasks.",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionStateProvider.notifier).setStart(!expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(
                AntDesign.circledown,
                // color: AppConst.kLight,
              )
            : const Icon(
                AntDesign.closecircleo,
                // color: AppConst.kBlueLight,
              ),
      ),
      children: [
        for (final todo in dayAfterTomorrowTasks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
            },
            editWidget: GestureDetector(
              onTap: () {
                titles = todo.title.toString();
                descs = todo.desc.toString();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateTask(id: todo.id ?? 0),
                  ),
                );
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            switcher: const SizedBox.shrink(),
          ),
      ],
    );
  }
}
