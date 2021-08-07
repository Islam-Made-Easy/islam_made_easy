import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:url_launcher/url_launcher.dart';

import 'anim/anim.dart';

void showFeedbackDialog({BuildContext context, bool isPanelVisible}) {
  final isDesktop = isDisplayDesktop(context);
  assert(context != null);
  showAnimatedDialog<void>(
    context: context,
    barrierDismissible: !isDesktop,
    animationType: isPanelVisible ? DialogTransitionType.slideFromRightFade : DialogTransitionType.size,
    builder: (context) => AppFeedback(),
  );
}

class AppFeedback extends StatefulWidget {
  @override
  _AppFeedbackState createState() => _AppFeedbackState();
}

class _AppFeedbackState extends State<AppFeedback> {
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController name, email, feed;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    feed = TextEditingController();
    super.initState();
  }

  void _submitFeed() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final feedback = FeedbackModel(name: name.text,email: email.text,feedback: feed.text);
      await FeedbackServices.insert([feedback.toJson()]);
      Get.snackbar('Submitting', 'Thank you for submitting your feedback!, Jazakumullahu Khayraa!!');
      name.clear(); email.clear(); feed.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    final labelStyle = Theme.of(context).textTheme.button.copyWith(
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
          'IME Feedback  Center',
          style: TextStyle(color: theme.textTheme.caption.color),
        ),
        automaticallyImplyLeading: !isDesktop,
        backgroundColor:
            isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
                ? Colors.transparent
                : theme.appBarTheme.color,
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
                    style: theme.textTheme.caption.copyWith(
                        fontFamily: 'Roboto',
                        fontSize: isDesktop || context.isTablet ? 26.0 : 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w100),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          isDesktop
                              ? "Assalam'alaikum warahmatullah Wabarakatuh,"
                              : "Assalam'alaikum warahmatullahو",
                        ),
                        TyperAnimatedText("Welcome to IME Feedback Center"),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ),
                ),
                Text(
                  "We can’t wait to get your thoughts on our app. Try help or support, have a question? We'd love to hear it.",
                  style: theme.textTheme.headline6
                      .copyWith(fontWeight: FontWeight.w100),
                ),
                SizedBox(height: 10),
                InputContainer(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Name can't be empty";
                    } else if (value.length < 4) {
                      return "Name is too short";
                    } else if (value.length > 32) {
                      return "Name is too long";
                    } else {
                      return null;
                    }
                  },
                  autoFocus: true,
                  inputType: TextInputType.name,
                  controller: name,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      labelStyle: labelStyle),
                ),
                InputContainer(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide your email';
                      // return "If you want to get updates regarding your feedback, enter your email";
                    } else if (!value.isEmail) {
                      return "Please enter a valid email";
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
                      hintText: 'Enter your email',
                      labelStyle: labelStyle,
                      labelText: 'Email'),
                ),
                InputContainer(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please provide your feedback";
                      } else if (value.length > 2048) {
                        return "Make it short and concise";
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
                        hintText: 'Leave your feedback or share ideas',
                        labelText: 'Feedback')),
                SizedBox(height: 20),
                StretchButton(onTap: _submitFeed, text: 'Submit'),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'We will not send you anything except for the content about your feedback.\n\nAlternatively  you can also report bugs and errors on the following platforms',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.caption.copyWith(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                              fontFamily: 'Roboto'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                color: theme.buttonColor,
                                tooltip: 'Github',
                                onPressed: () => launchUrl(
                                    "https://github.com/Islam-Made-Easy/Islam-Made-Easy/issues"),
                                icon: FaIcon(FontAwesomeIcons.github),
                                splashRadius: 1),
                            SizedBox(width: 10),
                            IconButton(
                                color: theme.buttonColor,
                                tooltip: 'Gitter',
                                onPressed: () => launchUrl(
                                    "https://gitter.im/orgs/Islam-Made-Easy/rooms"),
                                icon: FaIcon(FontAwesomeIcons.gitter),
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
}

class InputContainer extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final TextInputType inputType;
  final String Function(String) validator;
  final bool autoFocus;
  final List<String> autofillHints;

  const InputContainer(
      {Key key, this.decoration, this.controller, this.autofillHints,
        this.validator, this.autoFocus = false, this.inputType}) : super(key: key);

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
                    style: theme.textTheme.button.copyWith(
                        fontSize: 10 * 1.3,
                        fontFamily: ar ? 'Amiri' : 'Roboto',
                        fontWeight: FontWeight.w100,
                        letterSpacing: 2),
                    autocorrect: true,
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
