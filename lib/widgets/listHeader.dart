import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  ListHeader({@required this.text, this.trailing});

  final String text;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: trailing == null ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            overflow: TextOverflow.clip,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w500),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
