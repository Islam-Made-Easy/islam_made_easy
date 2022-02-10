import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';
import 'package:url_launcher/url_launcher.dart';

void showFeedbackDialog(BuildContext context, bool isPanelVisible) {
  final isDesktop = isDisplayDesktop(context);
  showAnimatedDialog<void>(
    context: context,
    barrierDismissible: !isDesktop,
    animationType: isPanelVisible
        ? DialogTransitionType.slideFromRightFade
        : DialogTransitionType.size,
    builder: (context) => AppFeedback(),
  );
}

class AppFeedback extends StatefulWidget {
  @override
  _AppFeedbackState createState() => _AppFeedbackState();
}

class _AppFeedbackState extends State<AppFeedback> {
  launchUrl(String url, bool? isWebView) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: isWebView!);
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
              fontFamily: ar ? 'Amiri' : 'Roboto'),
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
                horizontal: size.width * 0.035,
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
                        final response = await submitData(
                          name: name!.text,
                          email: email!.text,
                          feed: feed!.text,
                        );
                        Get.snackbar(
                            response == 200 ? 'Submitted' : 'Error!',
                            response == 200
                                ? 'Thank you for submitting your feedback!, Jazakumullahu Khayraa!!'
                                : 'Try back later',
                            colorText: response == 200 ? null : Colors.red,
                            snackPosition: SnackPosition.BOTTOM);
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
                            IconButton(
                                color: theme.buttonColor,
                                tooltip: 'Github',
                                onPressed: () => launchUrl(
                                    "https://github.com/Islam-Made-Easy/Islam-Made-Easy/issues",
                                    DeviceOS.isWeb),
                                icon: FaIcon(FontAwesomeIcons.github),
                                splashRadius: 1),
                            SizedBox(width: 10),
                            IconButton(
                                color: theme.buttonColor,
                                tooltip: 'Gitter',
                                onPressed: () => launchUrl(
                                    "https://gitter.im/orgs/Islam-Made-Easy/rooms",
                                    DeviceOS.isWeb),
                                icon: FaIcon(FontAwesomeIcons.gitter),
                                splashRadius: 1),
                            SizedBox(width: 10),
                            IconButton(
                                color: theme.buttonColor,
                                tooltip: 'Mail',
                                onPressed: () {
                                  sendViaEmail('');
                                  launchUrl("mailto:info.islamadeasy@gmail.com",
                                      DeviceOS.isWeb);
                                },
                                icon: FaIcon(Icons.mail),
                                splashRadius: 1),
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

  Future submitData({
    required String name,
    required String email,
    required String feed,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email');
    const serviceId = 'service_v3buc5h';
    const templateId = 'template_lvbfme7';
    const userId = 'user_QPzEf7RiM430WtpDknE2Y';
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        }, //This line makes
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': feed
          }
        }));
    return response.statusCode;
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
              height: size.height * 0.13,
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
