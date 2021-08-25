import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/locale/localePro.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:provider/provider.dart';

class SettingsRadio extends StatefulWidget {
  final String? subtitle;
  final int? value;

  const SettingsRadio({Key? key, this.subtitle, this.value}) : super(key: key);

  @override
  _SettingsRadioState createState() => _SettingsRadioState();
}

class _SettingsRadioState extends State<SettingsRadio> {
  String? selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    selectedLanguage = SpUtil.getLanguage() ?? '';
  }

  void _changeLanguage(String? languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      SpUtil.setLanguage(selectedLanguage!);
      Locale? locale = StringUtil.isNullOrEmpty(selectedLanguage!)
          ? null : Locale(languageCode!);
      Provider.of<LocaleProvide>(context,listen: false).changeLocale(locale);
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      RadioListTile(
        title: Text(getLanguageUiString(
            S.delegate.supportedLocales[widget.value!].languageCode),style: Theme.of(context).textTheme.button!.copyWith(
            fontSize: 10 * 1.5,fontFamily: ar?'Amiri':'Roboto',
            fontWeight: FontWeight.w400,
            letterSpacing: 2
        )),
        subtitle: Text(widget.subtitle!,style: Theme.of(context).textTheme.button!.copyWith(
            fontSize: 10 * 1.3,fontFamily: ar?'Amiri':'Roboto',
            fontWeight: FontWeight.w100,
            letterSpacing: 2
        )), activeColor: Theme.of(context).primaryColor,
        groupValue: selectedLanguage,
        value: S.delegate.supportedLocales[widget.value!].languageCode,
        onChanged: (String? languageCode) => _changeLanguage(languageCode),
      ),
    );
  }
}

String getLanguageUiString(String languageCode) {
  String uiString = S.current!.systemDefault;
  switch (languageCode.toLowerCase()) {
    case 'en':
      uiString = S.current!.english;
      break;
    case 'ar':
      uiString = S.current!.arabic;
      break;
    case 'bs':
      uiString = S.current!.bosnian;
      break;
    case 'da':
      uiString = S.current!.danish;
      break;
    case 'de':
      uiString = S.current!.deutsch;
      break;
    case 'hi':
      uiString = S.current!.hindi;
      break;
    case 'hr':
      uiString = S.current!.croatian;
      break;
    case 'id':
      uiString = S.current!.indonesia;
      break;
    case 'sr':
      uiString = S.current!.serbia;
      break;
    case 'sw':
      uiString = S.current!.swahili;
  }
  return uiString;
}
