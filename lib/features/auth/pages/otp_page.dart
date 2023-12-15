import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/common/widgets/app_style.dart';
import 'package:todo_app/common/widgets/reusable_text.dart';
import 'package:todo_app/features/auth/controllers/auth_controller.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/height_spacer.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({Key? key, required this.smsCodeId, required this.phone})
      : super(key: key);

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtp(
          context: context,
          smsCodeId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeightSpacer(height: AppConst.kHeight * 0.12),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Image.asset(
                  "assets/images/todo.webp",
                  width: AppConst.kWidth * 0.5,
                ),
              ),
              const HeightSpacer(height: 26.0),
              ReusableText(
                text: "Please enter your otp code",
                style: appStyle(18.0, AppConst.kLight, FontWeight.bold),
              ),
              const HeightSpacer(height: 26.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (value) {
                    if (value.length == 6) {
                      return verifyOtpCode(context, ref, value);
                    }
                  },
                  onSubmitted: (value) {
                    if (value.length == 6) {
                      return verifyOtpCode(context, ref, value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
