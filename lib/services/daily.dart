import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DailyNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String author = "";
  String quote = "";

  init() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings("@drawable/notification");
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
    ];

    var randomNumber = Random().nextInt(10);
    print(randomNumber);
    return quoteJson[randomNumber];
  }

  getAuthor() => this.author;

  getQuote() => this.quote;

  Future onSelectNotification(String payload) {
    print("Clicked");
  }
}
