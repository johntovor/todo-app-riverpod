// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    this.color,
    this.title,
    this.description,
    this.start,
    this.end,
    this.editWidget,
    this.delete,
    this.switcher,
  }) : super(key: key);
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.0.h),
            width: AppConst.kWidth,
            decoration: BoxDecoration(
              color: AppConst.kGreyLight,
              borderRadius: BorderRadius.all(
                Radius.circular(AppConst.kRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppConst.kRadius),
                        ),
                        // TODO: ADD DYNAMIC COLORS
                        color: color ?? AppConst.kRed,
                      ),
                    ),
                    const WidthSpacer(width: 15.0),
                    Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: SizedBox(
                        width: AppConst.kWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title of Todo",
                              style: appStyle(
                                  18.0, AppConst.kLight, FontWeight.bold),
                            ),
                            const HeightSpacer(height: 3.0),
                            ReusableText(
                              text: description ?? "Description of Todo",
                              style: appStyle(
                                  12.0, AppConst.kLight, FontWeight.bold),
                            ),
                            const HeightSpacer(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.3,
                                      color: AppConst.kGreyDk,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppConst.kRadius),
                                    ),
                                    color: AppConst.kBkDark,
                                  ),
                                  child: Center(
                                    child: ReusableText(
                                      text: "$start | $end",
                                      style: appStyle(12, AppConst.kLight,
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                                const WidthSpacer(width: 20.0),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    const WidthSpacer(width: 20.0),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0.h, right: 30),
                  width: AppConst.kWidth * 0.09,
                  child: switcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
