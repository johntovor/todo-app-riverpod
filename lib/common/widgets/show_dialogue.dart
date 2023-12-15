import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import 'app_style.dart';
import 'reusable_text.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
            text: message,
            style: appStyle(18.0, AppConst.kLight, FontWeight.w600),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                btnText ?? "OK",
                style: appStyle(18, AppConst.kGreyLight, FontWeight.w600),
              ),
            ),
          ],
        );
      });
}
