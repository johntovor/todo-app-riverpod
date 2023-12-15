import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todo_app/common/widgets/show_dialogue.dart';

import '../../../common/helpers/notifications_helper.dart';
import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_outline_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/height_spacer.dart';
import '../controllers/dates/dates_provider.dart';
import '../controllers/todo/todo_provider.dart';
import 'home_page.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  late NotificationsHelper notifierHelper;
  late NotificationsHelper controller;

  List<int> notification = [];

  @override
  void initState() {
    notifierHelper = NotificationsHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationsHelper(ref: ref);
    });
    notifierHelper.initializeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String scheduleDate = ref.watch(dateStateProvider);
    String startTime = ref.watch(startTimeStateProvider);
    String endTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "Add title",
              controller: title,
              hintStyle: appStyle(16.0, AppConst.kGreyLight, FontWeight.w600),
            ),
            const HeightSpacer(height: 20),
            CustomTextField(
              hintText: "Add description",
              controller: desc,
              hintStyle: appStyle(16.0, AppConst.kGreyLight, FontWeight.w600),
            ),
            const HeightSpacer(height: 20),
            CustomOutlineButton(
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kLight,
              color2: AppConst.kBlueLight,
              text: scheduleDate == ""
                  ? "Set Date"
                  : scheduleDate.substring(0, 10),
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 1, 1),
                    maxTime: DateTime(2030, 1, 1),
                    theme: const picker.DatePickerTheme(
                        doneStyle:
                            TextStyle(color: AppConst.kGreen, fontSize: 16)),
                    onConfirm: (date) {
                  ref.read(dateStateProvider.notifier).setDate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
            ),
            const HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineButton(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setStartTime(date.toString());
                      notification =
                          ref.read(startTimeStateProvider.notifier).dates(date);
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kLight,
                  color2: AppConst.kBlueLight,
                  text: startTime == ""
                      ? "Start Time"
                      : startTime.substring(11, 16),
                ),
                CustomOutlineButton(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(finishTimeStateProvider.notifier)
                          .setFinishTime(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kLight,
                  color2: AppConst.kBlueLight,
                  text: endTime == "" ? "End Time" : endTime.substring(11, 16),
                ),
              ],
            ),
            const HeightSpacer(height: 20),
            CustomOutlineButton(
              onTap: () {
                if (title.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  Task task = Task(
                    title: title.text,
                    desc: desc.text,
                    isCompleted: 0,
                    date: scheduleDate,
                    startTime: startTime.substring(11, 16),
                    endTime: endTime.substring(11, 16),
                    remind: 0,
                    repeat: "Yes",
                  );
                  notifierHelper.schedulNotification(notification[0],
                      notification[1], notification[2], notification[3], task);
                  ref.read(todoStateProvider.notifier).addItem(task);
                  // ref.read(dateStateProvider.notifier).setDate("");
                  // ref.read(startTimeStateProvider.notifier).setStartTime("");
                  // ref.read(finishTimeStateProvider.notifier).setFinishTime("");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } else {
                  showAlertDialog(
                      context: context, message: "Failed to add task");
                }
              },
              width: AppConst.kWidth * 0.42,
              height: 52.h,
              color: AppConst.kLight,
              color2: AppConst.kGreen,
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
