import 'package:flutter/foundation.dart';
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
import 'package:islam_made_easy/theme/themePro.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:provider/provider.dart';
import 'package:system_alert_window/system_alert_window.dart' as sys;
import 'package:get/get.dart';
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
    // getPermission();
    // sys.SystemAlertWindow.registerOnClickListener(exitWindow);
    selectedLanguage = SpUtil.getLanguage() ?? '';
  }

  // getPermission() async {
  //   await sys.SystemAlertWindow.checkPermissions;
  // }

  void exitWindow(tag) {
    if (tag == 'Exit') {
      sys.SystemAlertWindow.closeSystemWindow();
    }
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      SpUtil.setLanguage(selectedLanguage);
      Locale locale = StringUtil.isNullOrEmpty(selectedLanguage)
          ? null
          : Locale(languageCode);
      Provider.of<LocaleProvide>(context,listen: false).changeLocale(locale);
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
        backgroundColor: isDesktop
            ? Colors.transparent
            : Theme.of(context).appBarTheme.color,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop||context.isTablet ? 20 :8.0,
          vertical: isDesktop||context.isTablet ? 30 : 8.0,
        ),
        children: [
          _SettingsTitle(title: S.current.customizeExp),
          _SettingsTitle(title: S.current.interface),
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
                tilePadding:  EdgeInsets.symmetric(vertical: context.isTablet?15:10, horizontal: context.isTablet?15:10),
                childrenPadding:
                    EdgeInsets.symmetric(vertical: context.isTablet?15:10, horizontal: context.isTablet?15:10),
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
                        kIsWeb
                            ? _SettingsShort(
                                title: MaterialLocalizations.of(context)
                                    .backButtonTooltip,
                                subtitle: 'Alt+Left',
                                icon: PixIcon.pix_arrow_left2,
                                color: Colors.brown,
                              )
                            : Container(),
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
                              kIsWeb
                                  ? Container()
                                  : _SettingsShort(
                                      title: MaterialLocalizations.of(context)
                                          .backButtonTooltip,
                                      subtitle: 'Alt+Left',
                                      icon: PixIcon.pix_arrow_left2,
                                      color: Colors.brown,
                                    ),
                              _SettingsShort(
                                title: "What's New in IME ",
                                subtitle: 'Ctrl+N',
                                icon: PixIcon.open_box,
                                color: Colors.amberAccent,
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
                    medalType: MedalType.Silver,
                    radius: 70.0,
                    iconColor: Colors.transparent,
                    iconSize: 60.0,
                  ),
                  Text(S.current.advancedInfo)
                  // RaisedButton(
                  //   onPressed: () {
                  //     sys.SystemAlertWindow.showSystemWindow(
                  //       gravity: sys.SystemWindowGravity.TOP,
                  //       margin: sys.SystemWindowMargin(left: 50),
                  //       header: sys.SystemWindowHeader(
                  //           padding: sys.SystemWindowPadding(left: 20),
                  //           decoration: sys.SystemWindowDecoration(
                  //               startColor: Theme.of(context).primaryColorDark,
                  //               endColor: Theme.of(context).backgroundColor),
                  //           title:
                  //               sys.SystemWindowText(text: 'Islam Made Easy')),
                  //       body: sys.SystemWindowBody(
                  //           padding: sys.SystemWindowPadding(left: 20),
                  //           decoration: sys.SystemWindowDecoration(
                  //             endColor: Theme.of(context).backgroundColor,
                  //           ),
                  //           rows: [
                  //             sys.EachRow(columns: [
                  //               sys.EachColumn(
                  //                   padding: sys.SystemWindowPadding(left: 20),
                  //                   decoration: sys.SystemWindowDecoration(
                  //                     startColor:
                  //                         Theme.of(context).primaryColorDark,
                  //                     endColor:
                  //                         Theme.of(context).backgroundColor,
                  //                   ),
                  //                   text: sys.SystemWindowText(text: 'IMEasy'))
                  //             ]),
                  //           ]),
                  //       height: 500,
                  //       footer: sys.SystemWindowFooter(buttons: [
                  //         sys.SystemWindowButton(
                  //           text: sys.SystemWindowText(text: 'Islam Made Easy'),
                  //           tag: 'tag',
                  //           decoration: sys.SystemWindowDecoration(
                  //             endColor: Theme.of(context).backgroundColor,
                  //           ),
                  //         )
                  //       ]),
                  //     );
                  //   },
                  //   child: Text('Minimize Window'),
                  // )
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
            Provider.of<ThemeProvide>(context,listen: false).changeTheme(i);
            SystemChrome.setSystemUIOverlayStyle(
                Provider.of<ThemeProvide>(context,listen: false).overlayStyle);
            FlutterStatusbarcolor.setStatusBarColor(Colors.primaries[i][700]);
            SpUtil.setThemeIndex(i);
          });
        },
        child: WidgetAnimator(
          Card(
            child: Container(
              width: context.isTablet?60:55,
              height: context.isTablet?60:55,
              decoration: BoxDecoration(
                color: Colors.primaries[i][700],
                border: Provider.of<ThemeProvide>(context,listen: false).themeIndex == i
                    ? _currentThemeBorder
                    : null,
              ),
            ),
          ),
        ),
      ));
    }
    return ExpansionTile(
      tilePadding:  EdgeInsets.symmetric(vertical: context.isTablet?15:10, horizontal: context.isTablet?15:10),
      childrenPadding:  EdgeInsets.symmetric(vertical: context.isTablet?15:10, horizontal: context.isTablet?15:10),
      leading: FaIcon(FontAwesomeIcons.palette),
      title: Text(
        S.current.chooseTheme,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      // subtitle: Text('Choose to join the brighter side'),
      children: <Widget>[Wrap(children: themeChildren)],
    );
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
        title: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child: Row(
            children: [FaIcon(icon, color: color.withOpacity(0.4)), Text(title)],
          ),
        ),
        trailing: Chip(
          label: Text(subtitle),
          backgroundColor: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}
