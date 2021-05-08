import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/page_decoration.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController feed = TextEditingController();

  void _submitFeed() {
    if (_formKey.currentState.validate()) {
      FeedbackModel fdModel = FeedbackModel(name.text, email.text, feed.text);
      FeedbackServices fdServices = FeedbackServices((String response) {
        print("Debug Response: $response");
        if (response == FeedbackServices.STATUS_SUCCESS) {
          Get.snackbar('Submitted',
              'Your Feedback is successfully submitted, Jazakumullahu Khayran!!');
        } else {
          Get.snackbar('An Error Occurred!', 'Please try later');
        }
      });
      Get.snackbar(
        'Submitting...',
        'Please wait while your feedback is being transmitted',
        instantInit: true,
        maxWidth: 200,
        showProgressIndicator: true,
        duration: Duration(seconds: 10),
        snackPosition: SnackPosition.BOTTOM,
        progressIndicatorBackgroundColor: Theme.of(context).primaryColorDark,
      );
      fdServices.submitFeed(fdModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          isDesktop || (context.isTablet && DeviceOS.isDesktopOrWeb)
              ? Colors.transparent
              : theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'IME Feedback  Center',
          style: TextStyle(color: Theme.of(context).textTheme.caption.color),
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
                      child: TyperAnimatedTextKit(
                        isRepeatingAnimation: false,
                        text: [
                          isDesktop
                              ? "Assalam'alaikum warahmatullah Wabarakatuh,"
                              : "Assalam'alaikum warahmatullahو",
                          "Welcome to IME Feedback Center",
                        ],
                        textStyle: TextStyle(
                            fontSize:
                                isDesktop || context.isTablet ? 26.0 : 22),
                      ),
                    )),
                Text(
                  "We can't wait to get your feedback on our application, tell ideas, request a feature or send an applause.",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 10),
                InputContainer(
                    inputType: TextInputType.name,
                    controller: name,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: 'Enter your name',
                        labelText: 'Name')),
                InputContainer(
                    inputType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: 'Enter your email',
                        labelText: 'Email')),
                InputContainer(
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

  const InputContainer(
      {Key key,
      @required this.decoration,
      @required this.controller,
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This can't be empty";
                      } else {
                        return null;
                      }
                    },
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
