import 'package:flutter/material.dart';

class ViewText extends StatelessWidget {
  final String data;

  const ViewText({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SelectableText(data,
        style: theme.textTheme.headline5
            .copyWith(fontWeight: FontWeight.w100, height: 1.8, fontSize: 17,));
  }
}
