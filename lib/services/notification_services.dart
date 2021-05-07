import 'package:islam_made_easy/views/QnA/qna.dart';

class NotificationServices extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _localNotifier =
      FlutterLocalNotificationsPlugin();

  navHome() => Get.to(() => Home());

  Future initialize() async {
    if (DeviceOS.isWeb) {}
    final FlutterLocalNotificationsPlugin localNotifier =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('log');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    // localNotifier.initialize(initializationSettings);
    await localNotifier.initialize(initializationSettings,
        onSelectNotification: navHome());
  }

  Future quizNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id', 'name', 'description',
        enableLights: true,
        color: Colors.blue.shade50,
        importance: Importance.Max,
        largeIcon: DrawableResourceAndroidBitmap('log'),
        styleInformation: MediaStyleInformation(
            htmlFormatTitle: true, htmlFormatContent: true),
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _localNotifier.show(
        0,
        S.current.salam,
        'The Quiz part is still under heavy development, it will be LIVE in the next releases In Sha Allah',
        platformChannelSpecifics,
        payload: 'Keep Reading! The Quiz is Coming');
  }

  Future dailyNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description',
        playSound: true,
        enableVibration: true,
        styleInformation: BigTextStyleInformation('',
            htmlFormatTitle: true,
            htmlFormatContent: true,
            summaryText: 'May Allah Make It Easy for ya'),
        enableLights: true,
        color: Get.theme.primaryColor,
        importance: Importance.Max,
        largeIcon: DrawableResourceAndroidBitmap('log'),
        priority: Priority.High,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _localNotifier.periodicallyShow(
      0,
      "IME Daily Reminder",
      getQuoteString(),
      RepeatInterval.Daily,
      platformChannelSpecifics,
    );
  }

  getQuoteString() {
    var quoteJson = [
      "“A believer commits a sin and then doesn’t stop worrying about it until he enters Jannah.\n— Hasan al-Basri, Kitab az-Zuhd by Imam Ahmad\n\nShaykh ul-Islaam Ibn Taymiyyah [رحمه الله] said: ",
      "“A believer commits a sin and then doesn’t stop worrying about it until he enters Jannah.\n— Hasan al-Basri, Kitab az-Zuhd by Imam Ahmad\n\nShaykh ul-Islaam Ibn Taymiyyah [رحمه الله] said: ",
      "❝A group from the Salaf, from them Sa'eed Bin Jubayr said: verily a servant does a good deed and due to it enters the Fire and verily a servant does an evil deed and due to it enters Paradise. ",
      "❝A group from the Salaf, from them Sa'eed Bin Jubayr said: verily a servant does a good deed and due to it enters the Fire and verily a servant does an evil deed and due to it enters Paradise. ",
      "Umar ibn ’Abdul-’Aziz passed by a man who had small stones in his hand he was playing with, while he said: ’O Allah, marry me to Al-Hur Al-’Īn. So ‘Umar leaned towards him and said: ‘Such a bad requester you are. Why don’t you throw away the stones and sincerely dedicate to Allah the du’a?’” \n ~ Al-Hilyah 5/287",
      "Umar ibn ’Abdul-’Aziz passed by a man who had small stones in his hand he was playing with, while he said: ’O Allah, marry me to Al-Hur Al-’Īn. So ‘Umar leaned towards him and said: ‘Such a bad requester you are. Why don’t you throw away the stones and sincerely dedicate to Allah the du’a?’” \n ~ Al-Hilyah 5/287",
      "From Badil Al-’Uqayli who said:\n”Fasting is the fortress of the worshippers.” \n~ Al-Jū’ 258",
      "From Badil Al-’Uqayli who said:\n”Fasting is the fortress of the worshippers.” \n~ Al-Jū’ 258",
      "Hindiyyah the wife of Ibrahim An-Nakh’i who said:\n”That Ibrahim used to fast one day and eat one day.” \n ~ Al-Hilyah 4/224",
      "Hindiyyah the wife of Ibrahim An-Nakh’i who said:\n”That Ibrahim used to fast one day and eat one day.” \n ~ Al-Hilyah 4/224",
      "Masruq: \n”I asked ’Aishah: ’What is allowed for a man of his wife when he is fasting?’ She said: ‘Everything except intercourse.’”\n ~ Musannaf ‘Abdur-Razzaq",
      "Masruq: \n”I asked ’Aishah: ’What is allowed for a man of his wife when he is fasting?’ She said: ‘Everything except intercourse.’”\n ~ Musannaf ‘Abdur-Razzaq",
      "Always be preoccupied and do something for your hereafter! Don’t be hesitant, don’t lose no opportunity or time. Hasten to it. Run to it. The priority is your hereafter. ~ Shaykh Musa Jibril حفظه الله",
      "Always be preoccupied and do something for your hereafter! Don’t be hesitant, don’t lose no opportunity or time. Hasten to it. Run to it. The priority is your hereafter. ~ Shaykh Musa Jibril حفظه الله",
    ];

    var randomNumber = Random().nextInt(10);
    print(randomNumber);
    return quoteJson[randomNumber];
    // this.author = authorJson[randomNumber];
  }

  Future unsubscribeNotification() async {
    await _localNotifier.cancelAll();
  }
}
