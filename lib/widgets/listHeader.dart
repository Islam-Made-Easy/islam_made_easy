import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  ListHeader({this.text, this.trailing, this.ar});

  final bool? ar;
  final String? text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: trailing == null ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text!,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontFamily: ar! ? 'Amiri' : 'Quicksand',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
