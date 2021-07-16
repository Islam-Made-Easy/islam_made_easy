import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  ListHeader({this.text, this.trailing, this.ar});

  final String text;
  final Widget trailing;
  final bool ar;

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
            style: Theme.of(context).textTheme.button.copyWith(
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
                fontFamily: ar ? 'Amiri' : 'Roboto'),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
