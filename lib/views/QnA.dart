import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
import 'package:morpheus/page_routes/morpheus_page_route.dart';

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
        isDesktop: isDesktop,
        title: S.current.questionsAndAnswers,
      ),
      body: EasyRefresh(
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
            children: [
              SettingsLinkButton(
                title: 'assets/images/drk.jpg',
                subtitle: S.current.tawheed,
                onTap: () => Navigator.push(
                  context,
                  MorpheusPageRoute(builder: (context) => Tawheed()),
                ),
              ),
              SettingsLinkButton(
                title: 'assets/images/msd.jpg',
                onTap: () => Navigator.push(
                  context,
                  MorpheusPageRoute(builder: (context) => Prayer()),
                ),
                subtitle: S.current.swalah,
              ),
              SettingsLinkButton(
                title: 'assets/images/eat.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Zakkah()),
                  );
                },
                subtitle: S.current.zakkah,
              ),
              SettingsLinkButton(
                title: 'assets/images/exq.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Fast()),
                  );
                },
                subtitle: S.current.swaum,
              ),
              SettingsLinkButton(
                title: 'assets/images/marhm.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Marriage()),
                  );
                },
                subtitle: S.current.nikkah,
              ),
              SettingsLinkButton(
                title: 'assets/images/img1.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Jinn()),
                  );
                },
                subtitle: S.current.jinn,
              ),
              SettingsLinkButton(
                title: 'assets/images/img2.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => DeathHereafter()),
                  );
                },
                subtitle: S.current.death,
              ),
              SettingsLinkButton(
                title: 'assets/images/rose2.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Lifestyle()),
                  );
                },
                subtitle: S.current.lifestyle,
              ),
              SettingsLinkButton(
                title: 'assets/images/ka.jpeg',
                onTap: () {
                  Navigator.push(
                    context,
                    MorpheusPageRoute(builder: (context) => Hajj()),
                  );
                },
                subtitle: S.current.hajj,
              ),
            ]),
      ),
    );
  }
}
