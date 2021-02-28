import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grafpix/icons.dart';
import 'package:grafpix/pixbuttons/medal.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/locale/localePro.dart';
import 'package:islam_made_easy/settings/settings_radio.dart';
import 'package:islam_made_easy/theme/theme.dart';
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:provide/provide.dart';

class Settings extends StatefulWidget {
  static const ROUTE_NAME = "/settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static final Border _currentThemeBorder =
      Border.all(width: 2.0, color: Color(0x66000000));
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle = textTheme.bodyText1
        .apply(color: colorScheme.onPrimary, fontFamily: 'Quattrocento');
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor:
          isDesktop ? Colors.transparent : Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(isDesktop ? S.current.preferences : S.current.settings,
            style: bodyTextStyle),
        automaticallyImplyLeading: isDesktop ? false : true,
        centerTitle: true,
        backgroundColor:
            isDesktop ? Colors.transparent : Theme.of(context).primaryColorDark,
        elevation: isDesktop ? 0 : 4,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 20 : 8.0,
          vertical: isDesktop ? 30 : 8.0,
        ),
        children: [
          _SettingsTitle(title: 'Customize Your experience'),
          _SettingsTitle(title: 'Interface'),
          Divider(endIndent: 30, indent: 30, height: 20),
          WidgetAnimator(
              Card(child: _chooseTheme(), color: Theme.of(context).cardColor)),
          SizedBox(height: 10),
          WidgetAnimator(
            Card(
              child: ExpansionTile(
                title: Text(S.current.language),
                leading: FaIcon(FontAwesomeIcons.language),
                subtitle: Text(getLanguageUiString(selectedLanguage)),
                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                children: [
                  RadioListTile(
                      title: Text(getLanguageUiString('')),
                      value: '',
                      groupValue: selectedLanguage,
                      onChanged: (String languageCode) =>
                          _changeLanguage(languageCode)),
                  SettingsRadio(subtitle: S.current.english, value: 0),
                  SettingsRadio(subtitle: S.current.arabi, value: 1),
                  SettingsRadio(subtitle: S.current.bosanski, value: 2),
                  SettingsRadio(subtitle: S.current.dansk, value: 3),
                  SettingsRadio(subtitle: S.current.german, value: 4),
                  SettingsRadio(subtitle: S.current.hindii, value: 5),
                  SettingsRadio(subtitle: S.current.croatianHR, value: 6),
                  SettingsRadio(subtitle: S.current.indonesian, value: 7),
                  SettingsRadio(subtitle: S.current.serbian, value: 8),
                  SettingsRadio(subtitle: S.current.kiswahili, value: 9),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          isDesktop ? _SettingsTitle(title: S.current.shortcuts) : Container(),
          isDesktop
              ? Divider(endIndent: 30, indent: 30, height: 20)
              : Container(),
          isDesktop
              ? WidgetAnimator(
                  Card(
                    child: ExpansionTile(
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      title: Text(S.current.shortcuts),
                      children: [
                        _SettingsShort(
                          title:
                              MaterialLocalizations.of(context).copyButtonLabel,
                          subtitle: 'Ctrl+C',
                          icon: PixIcon.pix_copy,
                          color: Colors.greenAccent,
                        ),
                        _SettingsShort(
                          title: MaterialLocalizations.of(context)
                              .pasteButtonLabel,
                          subtitle: 'Ctrl+V',
                          icon: PixIcon.pix_paste,
                          color: Colors.orangeAccent,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFAFAFC).withOpacity(0.5),
                            border: Border.all(
                                color: Color(0xFFFAFAFC).withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              _SettingsShort(
                                title: MaterialLocalizations.of(context)
                                    .searchFieldLabel,
                                subtitle: 'Ctrl+F',
                                icon: PixIcon.pix_search,
                                color: Colors.blueAccent,
                              ),
                              _SettingsShort(
                                title: MaterialLocalizations.of(context)
                                    .backButtonTooltip,
                                subtitle: 'Alt+Left',
                                icon: PixIcon.pix_arrow_left2,
                                color: Colors.brown,
                              ),
                              _SettingsShort(
                                title: S.current.qDocs,
                                subtitle: 'Ctrl+Q',
                                icon: PixIcon.typcn_document,
                                color: Colors.deepPurple,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          _SettingsTitle(title: S.current.advanced),
          Divider(endIndent: 30, indent: 30, height: 20),
          WidgetAnimator(
            Card(
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                title: Text(S.current.advanced),
                children: [
                  PixMedal(
                    icon: Icons.build,
                    medalType: MedalType.Bronze,
                    radius: 70.0,
                    iconColor: Colors.transparent,
                    iconSize: 60.0,
                  ),
                  Text(S.current.advancedInfo)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ExpansionTile _chooseTheme() {
    final List<Widget> themeChildren = [];
    for (int i = 0; i < Colors.primaries.length; i++) {
      themeChildren.add(InkWell(
        onTap: () {
          setState(() {
            Provide.value<ThemeProvide>(context).changeTheme(i);
            SystemChrome.setSystemUIOverlayStyle(
                Provide.value<ThemeProvide>(context).overlayStyle);
            FlutterStatusbarcolor.setStatusBarColor(Colors.primaries[i][700]);
            SpUtil.setThemeIndex(i);
          });
        },
        child: WidgetAnimator(
          Card(
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.primaries[i][700],
                border: Provide.value<ThemeProvide>(context).themeIndex == i
                    ? _currentThemeBorder
                    : null,
              ),
            ),
          ),
        ),
      ));
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      childrenPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      leading: FaIcon(FontAwesomeIcons.palette),
      title: Text(
        S.current.chooseTheme,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      // subtitle: Text('Choose to join the brighter side'),
      children: <Widget>[Wrap(children: themeChildren)],
    );
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
}

class _SettingsTitle extends StatelessWidget {
  final String title;

  const _SettingsTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SettingsShort extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SettingsShort({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      ListTile(
        title: Row(
          children: [FaIcon(icon, color: color.withOpacity(0.4)), Text(title)],
        ),
        trailing: Chip(
          label: Text(subtitle),
          backgroundColor: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}
