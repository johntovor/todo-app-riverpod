import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/app_style.dart';
import "../../../common/widgets/reusable_text.dart";
import '../controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(
              text: code,
              style: appStyle(30, AppConst.kLight, FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(codeStateProvider.notifier)
                    .setStart("Hello New String");
              },
              child: const Text(
                "Click Me",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
