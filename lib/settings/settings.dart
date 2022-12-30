import 'package:flutter/cupertino.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:islam_made_easy/settings/settings_pro.dart';
import 'package:islam_made_easy/settings/settings_radio.dart';
import 'package:islam_made_easy/utils/spUtil.dart';
import 'package:islam_made_easy/utils/string_util.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static const ROUTE_NAME = "/settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with AutomaticKeepAliveClientMixin {
  static final Border bd = Border.all(width: 2.0, color: Color(0x66000000));
  String? selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    selectedLanguage = SpUtil.getLanguage() ?? '';
  }

  @override
  bool get wantKeepAlive => true;

  void _changeLanguage(String? languageCode) {
    setState(() {
      selectedLanguage = languageCode;
      SpUtil.setLanguage(selectedLanguage!);
      Locale? locale = StringUtil.isNullOrEmpty(selectedLanguage!)
          ? null
          : Locale(languageCode!);
      Provider.of<SettingProvide>(context, listen: false).changeLocale(locale);
      // TODO: Get permission before restart in future if relevant
      // relevance ^> if the data[translation files] is from remote source.
      if (DeviceOS.isDesktop) {
        Get.dialog(widget);
      }
      // Needs to 'rebirth' to update the ui since GetMaterialApp is not effective
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    TextStyle? _selectedFontTextStyle;
    List<String> _gFonts = [
      "Abril Fatface",
      "Aclonica",
      "Alegreya Sans",
      "Amiri",
      "Architects Daughter",
      "Archivo",
      "Archivo Narrow",
      "Bebas Neue",
      "Bitter",
      "Bree Serif",
      "Bungee",
      "Cabin",
      "Cairo",
      "Coda",
      "Comfortaa",
      "Comic Neue",
      "Cousine",
      "Croissant One",
      "Faster One",
      "Forum",
      "Great Vibes",
      "Heebo",
      "Inconsolata",
      "Josefin Slab",
      "Lato",
      "Libre Baskerville",
      "Lobster",
      "Lora",
      "Merriweather",
      "Montserrat",
      "Mukta",
      "Nunito",
      "Offside",
      "Open Sans",
      "Oswald",
      "Overlock",
      "Pacifico",
      "Playfair Display",
      "Poppins",
      "Raleway",
      "Roboto",
      "Roboto Mono",
      "Source Sans Pro",
      "Space Mono",
      "Spicy Rice",
      "Squada One",
      "Sue Ellen Francisco",
      "Trade Winds",
      "Ubuntu",
      "Varela",
      "Vollkorn",
      "Work Sans",
      "Zilla Slab"
    ];
    super.build(context);
    final MaterialLocalizations localize = MaterialLocalizations.of(context);
    final theme = Theme.of(context);
    final bodyTextStyle = theme.textTheme.bodyText1!
        .apply(color: theme.colorScheme.onPrimary, fontFamily: 'Roboto');
    final isDesktop = isDisplayDesktop(context);
    String txt =
        context.isDarkMode ? S.current.switchLight : S.current.switchDark;
    final title = theme.textTheme.button!.copyWith(
        fontSize: kSpacingUnit * 1.5,
        fontFamily: ar ? 'Amiri' : 'Quicksand',
        fontWeight: FontWeight.w400,
        letterSpacing: 2);
    final sub = theme.textTheme.button!.copyWith(
        fontSize: kSpacingUnit * 1.3,
        fontFamily: ar ? 'Amiri' : 'Roboto',
        fontWeight: FontWeight.w100,
        letterSpacing: 2);
    return Scaffold(
      backgroundColor: isDesktop ? Colors.transparent : null,
      appBar: AppBar(
        title: Text(isDesktop ? S.current.preferences : S.current.settings,
            style: bodyTextStyle),
        automaticallyImplyLeading: isDesktop ? false : true,
        centerTitle: true,
        backgroundColor: isDesktop ? Colors.transparent : null,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop || context.isTablet ? 20 : 8.0,
          vertical: isDesktop || context.isTablet ? 30 : 8.0,
        ),
        children: [
          _SettingsTitle(title: S.current.customizeExp),
          _SettingsTitle(title: S.current.interface),
          Image.asset('assets/images/1.png',
              color: Theme.of(context).primaryColor.withOpacity(.5)),
          WidgetAnimator(
            Card(
              child: Column(
                children: [
                  _chooseTheme(ar),
                  SettingsButton(
                    title: S.current.darkMode,
                    subtitle: txt,
                    value: ThemeProvide.isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        Provider.of<SettingProvide>(context, listen: false)
                            .getDark(value);
                        SpUtil.setDarkTheme(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          WidgetAnimator(
            Card(
              child: ExpansionTile(
                title: Text(S.current.language, style: title),
                leading: FaIcon(
                  FontAwesomeIcons.language,
                  color: theme.primaryColor,
                ),
                subtitle:
                    Text(getLanguageUiString(selectedLanguage!), style: sub),
                tilePadding: EdgeInsets.symmetric(
                    vertical: context.isTablet ? 15 : 10,
                    horizontal: context.isTablet ? 15 : 10),
                childrenPadding: EdgeInsets.symmetric(
                    vertical: context.isTablet ? 15 : 10,
                    horizontal: context.isTablet ? 15 : 10),
                children: [
                  RadioListTile(
                      activeColor: Theme.of(context).primaryColor,
                      title: Text(getLanguageUiString('')),
                      value: '',
                      groupValue: selectedLanguage,
                      onChanged: (String? languageCode) =>
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
              ? Image.asset('assets/images/1.png',
                  color: Theme.of(context).primaryColor.withOpacity(.5))
              : Container(),
          isDesktop
              ? WidgetAnimator(
                  Card(
                    child: ExpansionTile(
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      title: Text(S.current.shortcuts, style: title),
                      leading: FaIcon(
                        FontAwesomeIcons.shapes,
                        color: theme.primaryColor,
                      ),
                      children: [
                        _SettingsShort(
                          title: S.current.preferences,
                          subtitle: 'Ctrl+Shift',
                          icon: FontAwesomeIcons.cog,
                          color: Colors.blue,
                        ),
                        _SettingsShort(
                          title: localize.copyButtonLabel,
                          subtitle: 'Ctrl+C',
                          icon: Icons.copy,
                          color: Colors.greenAccent,
                        ),
                        _SettingsShort(
                          title: localize.pasteButtonLabel,
                          subtitle: 'Ctrl+V',
                          icon: Icons.paste,
                          color: Colors.orangeAccent,
                        ),
                        _SettingsShort(
                          title: localize.backButtonTooltip,
                          subtitle: 'Alt+Left',
                          icon: Icons.arrow_back,
                          color: Colors.brown,
                        ),
                        _SettingsShort(
                          title: S.current.qDocs,
                          subtitle: 'Ctrl+Alt',
                          icon: Icons.description,
                          color: Colors.deepPurple,
                        ),
                        // Below shortcuts are Not Implemented at the moment >>> We accept PR
                        Container(
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? theme.cardColor.withOpacity(.55)
                                : Color(0xFFFAFAFC).withOpacity(.5),
                            border: Border.all(
                                color: Color(0xFFFAFAFC).withOpacity(.5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              _SettingsShort(
                                title: localize.searchFieldLabel,
                                subtitle: 'Ctrl+F',
                                icon: Icons.search,
                                color: Colors.blueAccent,
                              ),
                              _SettingsShort(
                                title: S.current.whatNew,
                                subtitle: 'Ctrl+N',
                                icon: Icons.assignment,
                                color: Colors.amberAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          _SettingsTitle(title: 'Fonts'),
          Image.asset(
            'assets/images/1.png',
            color: Theme.of(context).primaryColor.withOpacity(.5),
          ),
          Card(
            child: ExpansionTile(
              title: Text('Change Font Size', style: title),
              leading: FaIcon(
                FontAwesomeIcons.slidersH,
                color: theme.primaryColor,
              ),
              children: [
                Slider(
                  label: Provider.of<SettingProvide>(context)
                      .fontSize!
                      .toDouble()
                      .toString(),
                  min: 12.0,
                  max: 22.0,
                  divisions: 5,
                  value: Provider.of<SettingProvide>(context).fontSize!,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<SettingProvide>(context, listen: false)
                          .getFontSize(value);
                      SpUtil.setFontSize(value);
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetAnimator(
            Card(
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                title: Text('Select Font', style: title),
                leading: FaIcon(
                  FontAwesomeIcons.font,
                  color: theme.primaryColor,
                ),
                children: [
                  FontPicker(
                      showInDialog: true,
                      onFontChanged: (font) {
                        setState(() {
                          Provider.of<SettingProvide>(context, listen: false)
                              .getFontFamily(font.fontFamily);
                          _selectedFontTextStyle = font.toTextStyle();
                          // SpUtil.setFont(font.fontFamily);
                          SpUtil.setFont(_selectedFontTextStyle!.fontFamily!);
                        });
                      },
                      googleFonts: _gFonts),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ExpansionTile _chooseTheme(bool ar) {
    final List<Widget> themeChildren = [];
    for (int i = 0; i < Colors.primaries.length; i++) {
      Color? color = context.isDarkMode
          ? Colors.primaries[i][900]
          : Colors.primaries[i][700];
      themeChildren.add(InkWell(
        onTap: () {
          setState(() {
            Provider.of<ThemeProvide>(context, listen: false).changeTheme(i);
            SystemChrome.setSystemUIOverlayStyle(
                Provider.of<ThemeProvide>(context, listen: false).overlayStyle);
            FlutterStatusbarcolor.setStatusBarColor(color!, animate: true);
            SpUtil.setThemeIndex(i);
          });
        },
        child: WidgetAnimator(
          Card(
            child: Container(
              width: context.isTablet ? 60 : 55,
              height: context.isTablet ? 60 : 55,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Provider.of<ThemeProvide>(context).themeIndex == i
                    ? bd
                    : null,
              ),
            ),
          ),
        ),
      ));
    }
    bool tab = context.isTablet;
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(
          vertical: tab ? 15 : 10, horizontal: tab ? 15 : 10),
      childrenPadding: EdgeInsets.symmetric(
          vertical: tab ? 15 : 10, horizontal: tab ? 15 : 10),
      leading: FaIcon(FontAwesomeIcons.palette,
          color: Theme.of(context).primaryColor),
      title: Text(
        S.current.chooseTheme,
        style: Theme.of(context).textTheme.button!.copyWith(
            fontSize: kSpacingUnit * 1.5,
            fontFamily: ar ? 'Amiri' : 'Roboto',
            fontWeight: FontWeight.w400,
            letterSpacing: 2),
      ),
      subtitle: Text(
        S.current.selectTheme,
        style: Theme.of(context).textTheme.button!.copyWith(
            fontSize: kSpacingUnit * 1.2,
            fontWeight: FontWeight.w100,
            fontFamily: 'Roboto',
            letterSpacing: 2),
      ),
      children: <Widget>[Wrap(children: themeChildren)],
    );
  }
}

class RestartDialog extends StatelessWidget {
  const RestartDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text('Restart'));
  }
}

class _SettingsTitle extends StatelessWidget {
  final String title;

  const _SettingsTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.button!.copyWith(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1.8),
      ),
    );
  }
}

class _SettingsShort extends StatelessWidget {
  final String? title, subtitle;
  final IconData? icon;
  final Color? color;

  const _SettingsShort(
      {Key? key, this.title, this.subtitle, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      ListTile(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FaIcon(icon, color: color!.withOpacity(.4)),
              Text(title!,
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: kSpacingUnit * 1.1,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2))
            ],
          ),
        ),
        trailing: Chip(
          label: Text(subtitle!,
              style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: kSpacingUnit * 1.3,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w100,
                  letterSpacing: 2)),
          backgroundColor: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String? title, subtitle;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const SettingsButton(
      {Key? key, this.title, this.subtitle, this.value, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return WidgetAnimator(
      ListTile(
        title: Text(
          title!,
          style: Theme.of(context).textTheme.button!.copyWith(
                fontSize: kSpacingUnit * 1.7,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
                fontFamily: ar ? 'Amiri' : 'Roboto',
              ),
        ),
        subtitle: Text(subtitle!,
            style: Theme.of(context).textTheme.button!.copyWith(
                fontSize: kSpacingUnit * 1.3,
                fontWeight: FontWeight.w100,
                fontFamily: ar ? 'Amiri' : 'Roboto',
                letterSpacing: 2)),
        trailing: CupertinoSwitch(
          value: value!,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
