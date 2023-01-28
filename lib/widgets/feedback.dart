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
        'mailto:info.islamadeasy@gmail.com?subject=IME Feedback&body=$messageContent');
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
    final style = Theme.of(context).textTheme.button!.copyWith(
          fontWeight: FontWeight.w300,
          fontFamily: 'Roboto',
          fontSize: 10 * 1.4,
          letterSpacing: 2,
        );
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
                      fontSize: isDesktop || context.isTablet ? 26.0 : 20,
                      fontFamily: ar ? 'Amiri' : 'Roboto',
                      fontWeight: FontWeight.w100,
                      letterSpacing: 1,
                    ),
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
                    fontFamily: ar ? 'Amiri' : 'Roboto',
                    fontWeight: FontWeight.w100,
                  ),
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
                  inputType: TextInputType.name,
                  autoFocus: true,
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
                    labelStyle: style,
                  ),
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
                      labelStyle: style,
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
                        labelStyle: style,
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
                            fontFamily: ar ? 'Amiri' : 'Roboto',
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2,
                          ),
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
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final InputDecoration? decoration;
  final TextInputType? inputType;
  final bool autoFocus;

  const InputContainer({
    this.autoFocus = false,
    this.autofillHints,
    this.decoration,
    this.controller,
    this.validator,
    this.inputType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final size = MediaQuery.of(context).size;
    final ar = locale.languageCode == 'ar';
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
                    maxLines: null,
                    autofocus: autoFocus,
                    validator: validator,
                    controller: controller,
                    decoration: decoration,
                    keyboardType: inputType,
                    autofillHints: autofillHints,
                    textInputAction: TextInputAction.newline,
                    smartQuotesType: SmartQuotesType.enabled,
                    style: theme.textTheme.button!.copyWith(
                      fontFamily: ar ? 'Amiri' : 'Roboto',
                      fontWeight: FontWeight.w100,
                      fontSize: 10 * 1.3,
                      letterSpacing: 2,
                    ),
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
