import 'package:flip_card/flip_card.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';

class References extends StatefulWidget {
  @override
  _ReferencesState createState() => _ReferencesState();
}

class _ReferencesState extends State<References> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.references),
        centerTitle: true,
        backgroundColor: isDesktop ? Colors.transparent : null,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 10 : 0, vertical: isDesktop ? 50 : 0),
        children: [
          Container(
            decoration: isDesktop
                ? BoxDecoration(
                    color: theme.cardColor.withOpacity(.2),
                    border: Border.all(color: theme.hoverColor),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      matchTextDirection: true,
                      image: AssetImage('assets/images/frame1.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        theme.hintColor.withOpacity(.4),
                        BlendMode.dst,
                      ),
                    ),
                  )
                : BoxDecoration(),
            padding: EdgeInsets.all(isDesktop ? 42 : 10),
            child: Column(
              children: [
                FlipCard(
                  front: _buildCardF(S.current.tawheedBookAuthor),
                  back: _buildCardB(S.current.tawheedAboutAuthor),
                ),
                FlipCard(
                  front: _buildCardF(S.current.prerequisiteAuthor),
                  back: _buildCardB(S.current.prerequisiteAboutAuthor),
                ),
                FlipCard(
                  front: _buildCardF(S.current.qnaAnswer1),
                  back: _buildCardB(S.current.aboutAlwan),
                ),
                FlipCard(
                  front: _buildCardF(S.current.hajjAuthor),
                  back: _buildCardB(S.current.aboutJibril),
                ),
                FlipCard(
                  front: _buildCardF(S.current.fatawaAuthor2),
                  back: _buildCardB(S.current.aboutFatawaAuthor2),
                ),
                FlipCard(
                  front: _buildCardF(S.current.tawheedIntroAuthor),
                  back: _buildCardB(
                      'Studied vocabulary, nahw (grammar) and sarf (morphology). Mainly translates '
                      'books of ‘aqīdah of the Salaf.\n${S.current.tawheedIntroTitle}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardF(String title) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Card(
      shape: GetPlatform.isWeb
          ? null
          : RoundedRectangleBorder(
              side: BorderSide(width: .5, color: Theme.of(context).hoverColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ar ? 0 : 10),
                topRight: Radius.circular(ar ? 10 : 0),
                bottomRight:
                    ar ? Radius.elliptical(90, 10) : Radius.elliptical(90, 10),
                bottomLeft: ar
                    ? Radius.elliptical(12, 200)
                    : Radius.elliptical(12, 200),
              ),
            ),
      elevation: GetPlatform.isWeb ? 10 : 30,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildCardB(String about) {
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    return Card(
      shape: GetPlatform.isWeb
          ? null
          : RoundedRectangleBorder(
              side: BorderSide(width: .5, color: Theme.of(context).hoverColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ar ? 0 : 10),
                topRight: Radius.circular(ar ? 10 : 0),
                bottomLeft:
                    ar ? Radius.elliptical(90, 10) : Radius.elliptical(12, 200),
                bottomRight:
                    ar ? Radius.elliptical(12, 200) : Radius.elliptical(90, 10),
              ),
            ),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          S.current.about,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          about,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
