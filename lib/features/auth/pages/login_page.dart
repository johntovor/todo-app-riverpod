import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/custom_outline_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/height_spacer.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/show_dialogue.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: "233",
    countryCode: "GH",
    e164Sc: 1,
    geographic: true,
    level: 1,
    name: "Ghana",
    example: "Ghana",
    displayName: "Ghana",
    displayNameNoCountryCode: "GH",
    e164Key: "",
  );

  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter your phone number");
    } else if (phone.text.length < 8) {
      return showAlertDialog(
          context: context, message: "Your phone number is too short");
    } else {
      ref.read(authControllerProvider).sendSms(
          context: context, phone: "+${country.phoneCode}${phone.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  "assets/images/todo.png",
                  width: 300.0,
                ),
              ),
              const HeightSpacer(height: 20.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.w),
                child: ReusableText(
                  text: "Please enter your phone number",
                  style: appStyle(17, AppConst.kLight, FontWeight.w500),
                ),
              ),
              const HeightSpacer(height: 20.0),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14.0),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: AppConst.kGreyLight,
                            bottomSheetHeight: AppConst.kHeight * 0.6,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppConst.kRadius),
                              topRight: Radius.circular(AppConst.kRadius),
                            ),
                          ),
                          onSelect: (code) {
                            setState(() {
                              country = code;
                            });
                          },
                        );
                      },
                      child: ReusableText(
                        text: "${country.flagEmoji} +${country.phoneCode}",
                        style:
                            appStyle(18.0, AppConst.kBkDark, FontWeight.bold),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  hintText: "Enter phone number",
                  hintStyle: appStyle(16.0, AppConst.kBkDark, FontWeight.w600),
                ),
              ),
              const HeightSpacer(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOutlineButton(
                  onTap: () {
                    sendCodeToUser();
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHeight * 0.075,
                  color: AppConst.kBkDark,
                  color2: AppConst.kLight,
                  text: "Send Code",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
