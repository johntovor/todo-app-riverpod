import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'titles.dart';

class XpansionTile extends StatelessWidget {
  const XpansionTile({
    Key? key,
    required this.text,
    required this.text2,
    required this.children,
    this.onExpansionChanged,
    this.trailing,
  }) : super(key: key);
  final String text;
  final String text2;
  // final bool? initiallyExpanded;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.kBkLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppConst.kRadius),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: BottomTitles(
            text: text,
            text2: text2,
          ),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          trailing: trailing,
          // initiallyExpanded: initiallyExpanded ?? false,
          children: children,
        ),
      ),
    );
  }
}
