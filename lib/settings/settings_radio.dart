import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/locale/localePro.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:provide/provide.dart';

class SettingsRadio extends StatefulWidget {
  final String subtitle;
  final int value;

  const SettingsRadio({Key key, @required this.subtitle, @required this.value})
      : super(key: key);

  @override
  _SettingsRadioState createState() => _SettingsRadioState();
}

class _SettingsRadioState extends State<SettingsRadio> {
  String selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    selectedLanguage = SpUtil.getLanguage() ?? '';
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      SpUtil.setLanguage(selectedLanguage);
      Locale locale = StringUtil.isNullOrEmpty(selectedLanguage)
          ? null
          : Locale(languageCode);
      Provide.value<LocaleProvide>(context).changeLocale(locale);
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      RadioListTile(
        title: Text(getLanguageUiString(
            S.delegate.supportedLocales[widget.value].languageCode)),
        subtitle: Text(widget.subtitle),
        groupValue: selectedLanguage,
        value: S.delegate.supportedLocales[widget.value].languageCode,
        onChanged: (String languageCode) => _changeLanguage(languageCode),
      ),
    );
  }
}

String getLanguageUiString(String languageCode) {
  String uiString = S.current.systemDefault;
  switch (languageCode.toLowerCase()) {
    case 'en':
      uiString = S.current.english;
      break;
    case 'ar':
      uiString = S.current.arabic;
      break;
    case 'bs':
      uiString = S.current.bosnian;
      break;
    case 'da':
      uiString = S.current.danish;
      break;
    case 'de':
      uiString = S.current.deutsch;
      break;
    case 'hi':
      uiString = S.current.hindi;
      break;
    case 'hr':
      uiString = S.current.croatian;
      break;
    case 'id':
      uiString = S.current.indonesia;
      break;
    case 'sr':
      uiString = S.current.serbia;
      break;
    case 'sw':
      uiString = S.current.swahili;
  }
  return uiString;
}
