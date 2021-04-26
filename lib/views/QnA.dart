import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/generated/l10n.dart';
import 'package:islam_made_easy/layout/adaptive.dart';
import 'package:islam_made_easy/views/QnA/Fast.dart';
import 'package:islam_made_easy/views/QnA/hajj.dart';
import 'package:islam_made_easy/views/QnA/jinn.dart';
import 'package:islam_made_easy/views/QnA/lifestyle.dart';
import 'package:islam_made_easy/views/QnA/marriage.dart';
import 'package:islam_made_easy/views/QnA/prayer.dart';
import 'package:islam_made_easy/views/QnA/tawheed.dart';
import 'package:islam_made_easy/views/QnA/zakkah.dart';
import 'package:islam_made_easy/widgets/appBar.dart';
import 'package:islam_made_easy/widgets/buttons/tileButton.dart';
import 'package:islam_made_easy/widgets/page_decoration.dart';

import 'QnA/death_hereafter.dart';

class QnA extends StatefulWidget {
  static const ROUTE_NAME = "/qna";

  @override
  _QnAState createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  EasyRefreshController _controller;

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: QnAppBar(
        isDesktop: isDesktop,color: isDesktop?Colors.transparent:null,
        title: S.current.questionsAndAnswers,
      ),
      body: Stack(
        children: [
          GradientCircles(),
          EasyRefresh(
            controller: _controller,
            child: GridView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 30 : 16.0,
                  vertical: 30.0,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: isDesktop ? 30 : 12,
                    crossAxisCount: isDesktop ? 4 : 2,
                    crossAxisSpacing: isDesktop ? 30 : 12),
                children:isDesktop
                    ? [
                  DesktopButton(openC: Tawheed(), title: 'assets/images/drk.jpg', subtitle: S.current.tawheed),
                  DesktopButton(openC: Prayer(), title: 'assets/images/msd.jpg', subtitle: S.current.swalah),
                  DesktopButton(openC: Zakkah(), title: 'assets/images/eat.jpg', subtitle: S.current.zakkah),
                  DesktopButton(openC: Fast(), title: 'assets/images/exq.jpg', subtitle: S.current.swaum),
                  DesktopButton(openC: Marriage(), title: 'assets/images/marhm.jpg', subtitle: S.current.nikkah),
                  DesktopButton(openC: Jinn(), title: 'assets/images/img1.jpg', subtitle: S.current.jinn),
                  DesktopButton(openC: DeathHereafter(), title: 'assets/images/img2.jpg', subtitle: S.current.death),
                  DesktopButton(openC: Lifestyle(), title: 'assets/images/rose2.jpg', subtitle: S.current.lifestyle),
                  DesktopButton(openC: Hajj(), title: 'assets/images/ka.jpeg', subtitle: S.current.hajj),
                ]
                    : [
                        SettingsLinkButton(title: 'assets/images/drk.jpg', subtitle: S.current.tawheed, onTap: () => Get.to(() => Tawheed(), transition: Transition.fadeIn),),
                        SettingsLinkButton(
                          title: 'assets/images/msd.jpg',
                          onTap: () => Get.to(() => Prayer(),
                              transition: Transition.fadeIn),
                          subtitle: S.current.swalah,
                        ),
                        SettingsLinkButton(
                          title: 'assets/images/eat.jpg',
                          onTap: () => Get.to(() => Zakkah(),
                              transition: Transition.fadeIn),
                          subtitle: S.current.zakkah,
                        ),
                        SettingsLinkButton(title: 'assets/images/exq.jpg', onTap: () => Get.to(() => Fast(), transition: Transition.fadeIn), subtitle: S.current.swaum,),
                        SettingsLinkButton(title: 'assets/images/marhm.jpg', onTap: () => Get.to(() => Marriage(), transition: Transition.fadeIn), subtitle: S.current.nikkah,),
                        SettingsLinkButton(title: 'assets/images/img1.jpg', onTap: () => Get.to(() => Jinn(), transition: Transition.fadeIn), subtitle: S.current.jinn,),
                        SettingsLinkButton(title: 'assets/images/img2.jpg', onTap: () => Get.to(() => DeathHereafter(),transition: Transition.fadeIn), subtitle: S.current.death,),
                        SettingsLinkButton(title: 'assets/images/rose2.jpg', onTap: () => Get.to(() => Lifestyle(), transition: Transition.fadeIn), subtitle: S.current.lifestyle,),
                        SettingsLinkButton(title: 'assets/images/ka.jpeg', onTap: () => Get.to(() => Hajj(), transition: Transition.fadeIn), subtitle: S.current.hajj,),
                      ]),
          ),
        ],
      ),
    );
  }
}