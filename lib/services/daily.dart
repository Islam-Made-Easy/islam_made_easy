import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class DailyNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String author = "";
  String quote = "";

  init() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings("@drawable/log");
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "Reminder",
      getQuoteString(),
      RepeatInterval.Hourly,
      platformChannelSpecifics,
    );
  }

  getQuoteString() {

    var quoteJson = [
      "“A believer commits a sin and then doesn’t stop worrying about it until he enters Jannah.\n— Hasan al-Basri, Kitab az-Zuhd by Imam Ahmad\n\nShaykh ul-Islaam Ibn Taymiyyah [رحمه الله] said: "
    "❝A group from the Salaf, from them Sa'eed Bin Jubayr said: verily a servant does a good deed and due to it enters the Fire and verily a servant does an evil deed and due to it enters Paradise. "
    "He does a good deed and is amazed by it and he boasts about it up until it enters him into the Fire. And he does an evil deed and his fear of it does not cease, neither does his repentance up until it enters him into paradise.❞\n\n[Al-Fatāwā, (10/294)",
      "I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best. \n- Marilyn Monroe",
      "Be yourself; everyone else is already taken. \n- Oscar Wilde",
      "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe. \n- Albert Einstein",
      "Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.\n- Bernard M. Baruch",
      "You've gotta dance like there's nobody watching,Love like you'll never be hurt,Sing like there's nobody listening,And live like it's heaven on earth. \n- William W. Purkey",
      "You know you're in love when you can't fall asleep because reality is finally better than your dreams.\n- Dr. Seuss",
      "A room without books is like a body without a soul. \n- Marcus Tullius Cicero",
      "So many books, so little time.\n- Frank Zappa",
      "You only live once, but if you do it right, once is enough. \n- Mae West",
      "Be the change that you wish to see in the world.\n- Mahatma Gandhi",
    ];

    var randomNumber = Random().nextInt(10);
    print(randomNumber);
    return  quoteJson[randomNumber];
    // this.author = authorJson[randomNumber];
  }

  getAuthor() => this.author;

  getQuote() => this.quote;

  Future onSelectNotification(String payload) {
    print("Clicked");
  }
}
