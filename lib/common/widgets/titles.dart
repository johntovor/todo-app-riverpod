import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/todo/controllers/todo/todo_provider.dart';
import '../utils/constants.dart';
import 'app_style.dart';
import 'height_spacer.dart';
import 'reusable_text.dart';
import 'width_spacer.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles(
      {Key? key, required this.text, required this.text2, this.clr})
      : super(key: key);

  final String text;
  final String text2;
  final Color? clr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var color =
                    ref.read(todoStateProvider.notifier).getRandomColors();
                return Container(
                  height: 80.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppConst.kRadius),
                    ),
                    color: color,
                  ),
                );
              },
            ),
            const WidthSpacer(width: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appStyle(24.0, AppConst.kLight, FontWeight.bold),
                  ),
                  const HeightSpacer(height: 10.0),
                  ReusableText(
                    text: text2,
                    style: appStyle(12.0, AppConst.kLight, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
