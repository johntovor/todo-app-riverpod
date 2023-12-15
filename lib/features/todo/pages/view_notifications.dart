import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/width_spacer.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({this.payload, Key? key}) : super(key: key);

  final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var start = payload!.split('|')[3];
    var finish = payload!.split('|')[4];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kHeight * 0.7,
                decoration: BoxDecoration(
                    color: AppConst.kBkLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius))),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Reminder",
                        style: appStyle(40, AppConst.kLight, FontWeight.bold),
                      ),
                      const HeightSpacer(height: 5.0),
                      Container(
                        width: AppConst.kWidth,
                        padding: EdgeInsets.only(left: 5.0.w),
                        decoration: BoxDecoration(
                          color: AppConst.kYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0.h),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Today",
                              style: appStyle(
                                  14, AppConst.kBkDark, FontWeight.bold),
                            ),
                            const WidthSpacer(width: 15.0),
                            ReusableText(
                              text: "From: $start To: $finish",
                              style: appStyle(
                                  14, AppConst.kBkDark, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const HeightSpacer(height: 10.0),
                      ReusableText(
                        text: title,
                        style: appStyle(30, AppConst.kLight, FontWeight.bold),
                      ),
                      const HeightSpacer(height: 10.0),
                      Text(
                        desc,
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: appStyle(16, AppConst.kLight, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: -10,
              child: Image.asset(
                'assets/images/bell.png',
                width: 70.w,
                height: 70.h,
              ),
            ),
            Positioned(
              bottom: -AppConst.kHeight * 0.143,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/notification.png',
                width: AppConst.kWidth * 0.8,
                height: AppConst.kHeight * 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
