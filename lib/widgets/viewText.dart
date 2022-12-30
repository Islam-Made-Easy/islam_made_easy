import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_pro.dart';

class ViewText extends StatelessWidget {
  final String? data;

  const ViewText({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? fontSize = Provider.of<SettingProvide>(context).fontSize;
    String? fontFamily = Provider.of<SettingProvide>(context).fontType;
    final theme = Theme.of(context);
    return SelectableText(
      data!,
      style: theme.textTheme.headline5!.copyWith(
        fontWeight: FontWeight.w100,
        fontFamily: fontFamily,
        fontSize: fontSize,
        height: 1.8,
      ),
    );
  }
}
