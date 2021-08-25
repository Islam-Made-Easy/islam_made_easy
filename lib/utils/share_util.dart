import 'package:islam_made_easy/views/QnA/qna.dart';

class ShareUtil {
  String? platformShare;

  String? getPlatformShare() {
    if (DeviceOS.isWeb) {
      platformShare = 'https://islamadeasy.page.link/share';
    } else if (DeviceOS.isLinux) {
      platformShare = 'https://snapcraft.io/islam-made-easy';
    } else if (DeviceOS.isMobile) {
      // todo: launch on PlayStore && AppStore In Sha Allah
      platformShare = 'Apk: https://github.com/Islam-Made-Easy/Islam-Made-Easy/releases\n';
    } else {
      platformShare = 'https://islamadeasy.page.link/share';
    }
    return platformShare;
  }
}
