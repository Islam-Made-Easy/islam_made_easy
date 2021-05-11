import 'package:islam_made_easy/views/QnA/qna.dart';

class NavigationPanel extends StatefulWidget {
  @override
  _NavigationPanelState createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  Widget drawerTile(String title, VoidCallback onTap, [IconData icon]) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        leading: Icon(icon, size: 35, color: colorScheme.secondary),
        dense: true,
        onTap: onTap,
        title: Text(title,
            style: TextStyle(color: colorScheme.surface, fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: <Widget>[
          drawerTile(
              S.current.prerequisite,
              () => Get.to(() => Prerequisite(), transition: Transition.size),
              PixIcon.typcn_document_text),
          drawerTile(
              S.current.questionsAndAnswers,
              () => Get.to(() => QnA(), transition: Transition.size),
              PixIcon.fab_quinscape),
          drawerTile(
              'Methodology',
              () => Get.to(() => Succinct(), transition: Transition.size),
              FontAwesomeIcons.bookOpen),
          drawerTile(
              S.current.generalKnowledge,
              () =>
                  Get.to(() => GeneralKnowledge(), transition: Transition.size),
              PixIcon.pix_book),
          drawerTile(
              S.current.references,
              () => Get.to(() => References(), transition: Transition.size),
              FontAwesomeIcons.scroll),
          drawerTile(
              S.current.shortPhrases,
              () => Get.to(() => ShortPhrases(), transition: Transition.size),
              PixIcon.fab_ussunnah),
        ],
      ),
    );
  }
}
