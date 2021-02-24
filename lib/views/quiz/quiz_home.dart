import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/views/home.dart';
import 'package:lottie/lottie.dart';

class FetchQuestions extends StatefulWidget {
  final String name;

  FetchQuestions({this.name});

  @override
  _FetchQuestionsState createState() => _FetchQuestionsState();
}

class _FetchQuestionsState extends State<FetchQuestions>
    with SingleTickerProviderStateMixin {
  String asset;

  setAsset() {
    if (widget.name == "Prayer") {
      asset = "assets/quiz/Prayer.json";
    } else if (widget.name == "Fast") {
      asset = "assets/quiz/Fast.json";
    } else if (widget.name == "Hajj") {
      asset = "assets/quiz/Hajj.json";
    } else if (widget.name == "Marriage") {
      asset = "assets/quiz/Marriage.json";
    } else if (widget.name == "History") {
      asset = "assets/quiz/History.json";
    } else if (widget.name == "Quran") {
      asset = "assets/quiz/Quran.json";
    } else if (widget.name == "Charity") {
      asset = "assets/quiz/Charity.json";
    } else {
      asset = "assets/quiz/History.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setAsset();
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(asset, cache: false),
      builder: (context, snapshot) {
        List data = json.decode(snapshot.data.toString());
        if (data == null) {
          return Scaffold(
            body: AnimatedBackground(
              behaviour: RectanglesBehaviour(),
              vsync: this,
              child: Center(child: Lottie.asset("assets/lottie/loader.json")),
            ),
          );
        } else {
          return QuizView(data: data, name: widget.name);
        }
      },
    );
  }
}

class QuizView extends StatefulWidget {
  final List data;
  final String name;

  QuizView({Key key, this.data, this.name}) : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> with TickerProviderStateMixin {
  Color showColor = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Get.theme.primaryColorDark;
  int marks = 0;
  int i = 1;
  int quest = 1;
  bool disableAnswer = false;

  // extra variable to iterate

  int timer = 30;
  String showTimer = "30";
  var randomArray;

  Map<String, Color> btnColor = {
    "a": Get.theme.hoverColor,
    "b": Get.theme.hoverColor,
    "c": Get.theme.hoverColor,
    "d": Get.theme.hoverColor,
  };

  bool cancelTimer = false;

  genRandomArray() {
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0;;) {
      distinctIds.add(rand.nextInt(20));
      randomArray = distinctIds.toSet().toList();
      if (randomArray.length < 20) {
        continue;
      } else {
        break;
      }
    }
  }

  @override
  void initState() {
    startTimer();
    genRandomArray();
    super.initState();
  }

  // overriding the setState function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void startTimer() async {
    const sec = Duration(seconds: 1);
    Timer.periodic(sec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (quest < 20) {
        i = randomArray[quest];
        quest++;
      } else {
        Get.off(ResultPage(marks: marks));
      }
      btnColor["a"] = Theme.of(context).hoverColor;
      btnColor["b"] = Theme.of(context).hoverColor;
      btnColor["c"] = Theme.of(context).hoverColor;
      btnColor["d"] = Theme.of(context).hoverColor;
      disableAnswer = false;
    });
    startTimer();
  }

  void checkAnswer(String k) {
    if (widget.data[2][i.toString()] == widget.data[1][i.toString()][k]) {
      marks += 5;
      showColor = right;
    } else {
      // debugPrint(widget.data[2]["1"] + " is equal to " + widget.data[1]["1"][k]);
      showColor = wrong;
    }
    setState(() {
      btnColor[k] = showColor;
      cancelTimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListTile(
        onTap: () => checkAnswer(k),
        tileColor: btnColor[k],
        title: Text(
          widget.data[1][i.toString()][k],
          style: TextStyle(fontSize: 16.0),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    if (isDesktop) {
      return WillPopScope(
        onWillPop: () {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Warning!!"),
              content: Text(
                  "Are you sure you want to quit the quiz? All your progress will be lost."),
              actions: <Widget>[
                FlatButton(
                  child: Text(S.current.no),
                  onPressed: () => Get.back(),
                ),
                FlatButton(
                  onPressed: () => Get.off(Home()),
                  child: Text(S.current.yes),
                )
              ],
            ),
          );
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(widget.name),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 200, vertical: 50),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFC).withOpacity(0.2),
                    border:
                        Border.all(color: Theme.of(context).backgroundColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipPath(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .backgroundColor
                                  .withOpacity(0.2)),
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.white70,
                                  child: Text("$quest"),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Text(
                                    widget.data[0][i.toString()],
                                    softWrap: true,
                                    style: _questionStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Card(
                              child: AbsorbPointer(
                                absorbing: disableAnswer,
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      choiceButton('a'),
                                      choiceButton('b'),
                                      choiceButton('c'),
                                      choiceButton('d'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  showTimer,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Amiri',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Warning!!"),
              content: Text(
                  "Are you sure you want to quit the quiz? All your progress will be lost."),
              actions: <Widget>[
                FlatButton(
                  child: Text(S.current.no),
                  onPressed: () => Get.back(),
                ),
                FlatButton(
                  onPressed: () => Phoenix.rebirth(context),
                  child: Text(S.current.yes),
                )
              ],
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(title: Text(widget.name), elevation: 0),
          body: Stack(
            children: <Widget>[
              ClipPath(
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).backgroundColor),
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: Text("$quest"),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Text(
                            widget.data[0][i.toString()],
                            softWrap: true,
                            style: _questionStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Card(
                      child: AbsorbPointer(
                        absorbing: disableAnswer,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              choiceButton('a'),
                              choiceButton('b'),
                              choiceButton('c'),
                              choiceButton('d'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale.languageCode == 'ar'
                              ? replaceArabicNumber(showTimer)
                              : showTimer,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Quattrocento',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '۷', '۸', '۹'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }
}

class ResultPage extends StatefulWidget {
  final int marks;

  const ResultPage({Key key, @required this.marks}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = ["", "", ""];
  bool showTips = false;
  String message =
      'Ma Sha Allah! May Allah reward your efforts of seeking knowledge ';
  String image;

  @override
  void initState() {
    if (widget.marks < 40) {
      showTips = true;
    } else if (widget.marks == 100) {
      showTips = true;
    }
    super.initState();
  }

  final TextStyle titleStyle = TextStyle(
      color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        elevation: 0,
        actions: [
          showTips
              ? AvatarGlow(
                  endRadius: 20,
                  showTwoGlows: true,
                  glowColor: Colors.yellow,
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.lightbulb,
                        color: Colors.yellow),
                    splashRadius: 10,
                    onPressed: () {
                      Get.dialog(AlertDialog(
                        title: Text("Did you know?"),
                        content: Text(
                            "You can improve your on your score by reading on the notes provided on different sections of this app."),
                        actions: <Widget>[
                          FlatButton(onPressed: () {}, child: Text('Next Tip')),
                          FlatButton(
                              onPressed: Get.back,
                              child: Text(MaterialLocalizations.of(context)
                                  .okButtonLabel))
                        ],
                      ));
                    },
                  ),
                )
              : Container()
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => Home(),
      //     ));
      //   },
      //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //   tooltip: MaterialLocalizations.of(context).nextPageTooltip,
      //   child: Container(
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20),
      //         color: colorScheme.secondary),
      //     child: IconButton(
      //       icon: FaIcon(
      //         S.delegate.supportedLocales == rtlLanguages
      //             ? FontAwesomeIcons.angleLeft
      //             : FontAwesomeIcons.angleRight,
      //         color: colorScheme.surface,
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (context) => FetchQuestions(name: 'name'),
      //         ));
      //       },
      //     ),
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [colorScheme.surface, colorScheme.secondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(message, style: titleStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Score", style: titleStyle),
                  trailing: Text("${widget.marks}%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 50.0),
              Positioned(
                left: 0,
                height: 20,
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                  color: colorScheme.secondary,
                  child: Text(
                    "Go Home",
                    style:
                        TextStyle(fontSize: 18.0, color: colorScheme.surface),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
