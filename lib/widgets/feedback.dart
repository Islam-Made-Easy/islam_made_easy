import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/page_decoration.dart';
import 'package:url_launcher/url_launcher.dart';

import 'anim/anim.dart';

void showFeedbackDialog({@required BuildContext context, bool isPanelVisible}) {
  final isDesktop = isDisplayDesktop(context);
  assert(context != null);
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
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController feed = TextEditingController();

  void _submitFeed() {
    if (_formKey.currentState.validate()) {
      FeedbackModel fdModel = FeedbackModel(name.text, email.text, feed.text);
      FeedbackServices fdServices = FeedbackServices();
      Get.snackbar(
        'Submitting...',
        'Please wait while your feedback is being submitted',
        instantInit: true,
        maxWidth: 200,
        showProgressIndicator: true,
        duration: Duration(seconds: 10),
        snackPosition: SnackPosition.BOTTOM,
        progressIndicatorBackgroundColor: Theme.of(context).primaryColorDark,
      );
      fdServices.submitForm(fdModel, (String response) {
        print("Response: $response");
        if (response == FeedbackServices.STATUS_SUCCESS) {
          Get.snackbar('Submitted',
              'Your Feedback is successfully submitted, Jazakumullahu Khayraa!!');
          name.clear(); email.clear(); feed.clear();
        } else {
          Get.snackbar('An Error Occurred!', 'Please try later');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor:
      isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
          ? Colors.transparent
          : theme.backgroundColor,
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
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            GradientCircles(),
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.035,
                vertical: isDesktop || context.isTablet ? 30 : 8.0,
              ),
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: isDesktop || context.isTablet ? 26.0 : 22),
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
                ),
                Text(
                  "We can't wait to get your feedback about our application, try help or support, have a question? We'd love to hear it.",
                  style: theme.textTheme.headline6,
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
                  inputType: TextInputType.name,
                  controller: name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                ),
                InputContainer(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email can't be empty";
                      } else if (!value.isEmail) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    inputType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: 'Enter your email',
                        labelText: 'Email')),
                InputContainer(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Feedback can't be empty";
                      } else if (value.length > 200) {
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
                          borderSide: BorderSide(
                              color: theme.primaryColorDark, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        border: InputBorder.none,
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
                              'We will not send you anything except for the content about your feedback.'),
                          Text(
                              'Alternatively  you can also report bugs and errors on the following platforms'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  tooltip:'Github',
                                  onPressed: () =>
                                      launchUrl(
                                          "https://github.com/Islam-Made-Easy/Islam-Made-Easy/issues"),
                                  icon: FaIcon(FontAwesomeIcons.github),
                                  splashRadius: 1),
                              SizedBox(width:10),
                              IconButton(
                                  tooltip:'Gitter',
                                  onPressed: () =>
                                      launchUrl(
                                          "https://gitter.im/orgs/Islam-Made-Easy/community"),
                                  icon: FaIcon(FontAwesomeIcons.gitter),
                                  splashRadius: 1),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ],
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

  const InputContainer({Key key,
    @required this.decoration,
    @required this.controller,
    this.validator,
    @required this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    final size = MediaQuery.of(context).size;
    return WidgetAnimator(
      Stack(
        children: [
          Card(
            color: Color(0xfff6f6f6),
            child: Container(
              height: size.height * 0.13,
              width: size.width - 45,
              child: Stack(
                children: [
                  TextFormField(
                    decoration: decoration,
                    textInputAction: TextInputAction.newline,
                    controller: controller,
                    autocorrect: true,
                    keyboardType: inputType,
                    maxLines: null,
                    validator: validator,
                  ),
                  Positioned(
                    left: ar ? null : 0,
                    right: ar ? 0 : null,
                    top: size.height * 0.05,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
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
