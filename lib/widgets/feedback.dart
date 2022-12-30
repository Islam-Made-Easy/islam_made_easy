import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:url_launcher/url_launcher.dart';

import 'buttons/custom_icon_button.dart';

void showFeedbackDialog(BuildContext context, bool isPanelVisible) {
  Get.dialog(
    AppFeedback(),
    name: 'Feedback',
    transitionCurve: Curves.easeOutQuad,
  );
}

class AppFeedback extends StatefulWidget {
  @override
  _AppFeedbackState createState() => _AppFeedbackState();
}

class _AppFeedbackState extends State<AppFeedback> {
  launchUrl(String url, bool? isWebView) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(url, isWebView!);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendViaEmail(String messageContent) {
    final emailLink = Uri.encodeFull(
        'mailto:info.islamadeasy@gmail.com?subject=Feedback IME&body=$messageContent');
    launchUrl(emailLink, DeviceOS.isWeb);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController? name, email, feed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    final labelStyle = Theme.of(context).textTheme.button!.copyWith(
        fontSize: 10 * 1.4,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        letterSpacing: 2);
    return Scaffold(
      backgroundColor:
          isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
              ? Colors.transparent
              : null,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.current.feedbackCentre,
          style: TextStyle(
              color: theme.textTheme.caption!.color,
              fontFamily: ar ? 'Amiri' : 'Quicksand'),
        ),
        automaticallyImplyLeading: !isDesktop,
        backgroundColor:
            isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
                ? Colors.transparent
                : theme.appBarTheme.backgroundColor,
      ),
      body: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * .035,
                vertical: isDesktop || context.isTablet ? 30 : 8.0,
              ),
              children: [
                SizedBox(
                  child: DefaultTextStyle(
                    style: theme.textTheme.caption!.copyWith(
                        fontFamily: ar ? 'Amiri' : 'Roboto',
                        fontSize: isDesktop || context.isTablet ? 26.0 : 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w100),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(S.current.salam),
                        TyperAnimatedText(S.current.welcomeFeedback),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                ),
                Text(
                  S.current.wait,
                  style: theme.textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w100,
                      fontFamily: ar ? 'Amiri' : 'Roboto'),
                ),
                SizedBox(height: 10),
                InputContainer(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.current.emptyName;
                    } else if (value.length < 4) {
                      return "Name is too short";
                    } else if (value.length > 32) {
                      return S.current.longName;
                    } else {
                      return null;
                    }
                  },
                  autoFocus: true,
                  inputType: TextInputType.name,
                  controller: name,
                  autofillHints: const [
                    AutofillHints.name,
                    AutofillHints.username
                  ],
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: S.current.enterName,
                      labelText: S.current.lName,
                      labelStyle: labelStyle),
                ),
                InputContainer(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return S.current.provideEmail;
                      // return "If you want to get updates regarding your feedback, enter your email";
                    } else if (!value.isEmail) {
                      return S.current.enterEmailValid;
                    } else {
                      return null;
                    }
                  },
                  inputType: TextInputType.emailAddress,
                  controller: email,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: S.current.enterEmail,
                      labelStyle: labelStyle,
                      labelText: S.current.email),
                ),
                InputContainer(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.current.provideFeed;
                      } else if (value.length > 2048) {
                        return S.current.makeShort;
                      } else {
                        return null;
                      }
                    },
                    inputType: TextInputType.multiline,
                    controller: feed,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        border: InputBorder.none,
                        labelStyle: labelStyle,
                        hintText: S.current.leaveFeed,
                        labelText: S.current.feedback)),
                SizedBox(height: 20),
                StretchButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // todo: get data to server :)
                        sendViaEmail(feed!.text);
                        name!.clear();
                        email!.clear();
                        feed!.clear();
                        setState(() {});
                      }
                    },
                    text: S.current.submit),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${S.current.notSend}\n\n${S.current.alternative}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                              fontFamily: ar ? 'Amiri' : 'Roboto'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                                icon: FontAwesomeIcons.github,
                                onTap: () => launchUrl(
                                    "https://github.com/Islam-Made-Easy/Islam-Made-Easy/issues",
                                    DeviceOS.isWeb),
                                data: 'Github'),
                            SizedBox(width: 10),
                            CustomIconButton(
                                icon: FontAwesomeIcons.gitter,
                                onTap: () => launchUrl(
                                    "https://gitter.im/orgs/Islam-Made-Easy/rooms",
                                    DeviceOS.isWeb),
                                data: 'Gitter'),
                            SizedBox(width: 10),
                            CustomIconButton(
                                icon: Icons.mail,
                                onTap: () {
                                  sendViaEmail(feed!.text);
                                  launchUrl("mailto:info.islamadeasy@gmail.com",
                                      DeviceOS.isWeb);
                                },
                                data: 'Mail'),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final List<String>? autofillHints;

  const InputContainer(
      {Key? key,
      this.decoration,
      this.controller,
      this.autofillHints,
      this.validator,
      this.autoFocus = false,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return WidgetAnimator(
      Stack(
        children: [
          Card(
            color: context.isDarkMode ? theme.cardColor : Color(0xfff6f6f6),
            child: Container(
              height: size.height * .13,
              width: size.width - 45,
              child: Stack(
                children: [
                  TextFormField(
                    autofillHints: autofillHints,
                    decoration: decoration,
                    textInputAction: TextInputAction.newline,
                    smartQuotesType: SmartQuotesType.enabled,
                    controller: controller,
                    style: theme.textTheme.button!.copyWith(
                        fontSize: 10 * 1.3,
                        fontFamily: ar ? 'Amiri' : 'Roboto',
                        fontWeight: FontWeight.w100,
                        letterSpacing: 2),
                    keyboardType: inputType,
                    maxLines: null,
                    validator: validator,
                    autofocus: autoFocus,
                  ),
                  Positioned(
                    left: ar ? null : 0,
                    right: ar ? 0 : null,
                    top: size.height * .05,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(' '),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
