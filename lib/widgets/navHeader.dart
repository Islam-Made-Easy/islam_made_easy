import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/utils/device_info.dart';
import 'package:islam_made_easy/views/about.dart' as about;

showSettings(BuildContext context) {
  final theme = Theme.of(context);
  Get.dialog(
    Align(
      alignment: Localizations.localeOf(context).languageCode == 'ar'
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: double.infinity,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.05),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
        ),
        child: Settings(),
      ),
    ),
    transitionDuration: DelayUI(Duration(milliseconds: 1000)).duration,
    transitionCurve: Curves.easeInOutSine,
    name: 'Preferences',
  );
}

class NavigationRailHeader extends StatelessWidget {
  const NavigationRailHeader({required this.extended});

  final ValueNotifier<bool?> extended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final animation = NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    InkWell(
                      key: const ValueKey(''),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Row(
                        children: [
                          Transform.rotate(
                            angle: animation.value * math.pi,
                            child: const FaIcon(Icons.arrow_left, size: 16),
                          ),
                          Image.asset('assets/images/Logo3.png', width: 32),
                          const SizedBox(width: 10),
                          Align(
                            widthFactor: animation.value,
                            alignment: AlignmentDirectional.centerStart,
                            child: Opacity(
                              opacity: animation.value,
                              child: Text(
                                'IME',
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                          SizedBox(width: 18 * animation.value),
                        ],
                      ),
                      hoverColor: theme.primaryColor.withOpacity(.1),
                      onTap: () => extended.value = !extended.value!,
                    ),
                    if (animation.value > 0)
                      Opacity(
                        opacity: animation.value,
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.gear,
                                color: theme.primaryColor,
                              ),
                              splashRadius: 15,
                              hoverColor: theme.primaryColor.withOpacity(.1),
                              onPressed: () => showSettings(context),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.info,
                                color: theme.primaryColor,
                              ),
                              onPressed: () => about.showAboutDialog(),
                              splashRadius: 15,
                              hoverColor: theme.primaryColor.withOpacity(.1),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
