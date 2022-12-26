import 'package:islam_made_easy/views/QnA/qna.dart';

class ShareUtil {
  String? shareLink;

  String? getPlatformShare() {
    if (DeviceOS.isWeb) {
      shareLink = 'https://islamadeasy.page.link/share';
    } else if (DeviceOS.isLinux) {
      shareLink = 'https://snapcraft.io/islam-made-easy';
    } else if (DeviceOS.isMobile) {
      // todo: launch on PlayStore && AppStore In Sha Allah
      shareLink =
          'Apk: https://github.com/Islam-Made-Easy/Islam-Made-Easy/releases\n';
    } else {
      shareLink = 'https://islamadeasy.page.link/share';
    }
    return shareLink;
  }
}
