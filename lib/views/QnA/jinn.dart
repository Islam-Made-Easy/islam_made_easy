import 'package:islam_made_easy/views/QnA/qna.dart';

class Jinn extends StatefulWidget {
  @override
  _JinnState createState() => _JinnState();
}

class _JinnState extends State<Jinn> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: QnAppBar(title: S.current.jinn, isDesktop: isDesktop),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: [
            InfoCard(
                quest:
                    'Can the Jinn take different forms and what are they created from?',
                answers: [ViewText(
                      data:
                          'The jinn are created from a smokeless flame of fire but they are of three kinds: \n'
                          '1) They flow through the air, fly. \n'
                          '2) They take the form of snakes and dogs, especially black dogs in particular.\n'
                          '3) They’re in the form of Bedouins and they live in the community here and there, as well as travelling from place to place. '
                          'Angels and Jinn can form but angels only take the form of good, likewise jinn and Shaytan can also form to good shape but also other than '
                          'that like dogs and snakes. \n'
                          'Shaytan can appear to any kind of people, for example: \n'
                          '1) Shaytan appeared to Amr Ibn Al-Luhay, the one who introduced the statues and shirk to Jaziratul Arab, the Arabian peninsula. \n'
                          '2) The Shaytan appeared to the disbelievers and idolaters of Quraysh the night the Prophet صلى الله عليه وسلم migrated to Medina. Shaytan came to them in the form of a well-respected wise man and he conspired with them on how to assassinate the Prophet صلى الله عليه وسلم. He '
                          'taught them what to do and how to conspire against the Prophet in order to assassinate him. Shaytan taught them to take one individual from '
                          'every tribe and all kill the Prophet at same time, this way his blood will be on the hands of all the tribes and won’t cause war to break '
                          'out. That was Shaytan’s plotting in the form of a man. \n3) Shaytan appeared on the day of Badr in form of Suraaqa Ibn Maalik and he said he’s going to help Quraysh in their war against the '
                          'Prophet صلى الله عليه وسلم and fight with them to encourage them. But then he abandoned them. ')]),
          ],
        ),
      ),
    );
  }
}
