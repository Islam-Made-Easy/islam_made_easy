import 'dart:ui';

import 'package:islam_made_easy/settings/settings.dart';
import 'package:islam_made_easy/theme/theme.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';
import 'package:islam_made_easy/widgets/anim/anim.dart';

import '../search_toolbar.dart';

class MainPanel extends StatefulWidget {
  @override
  _MainPanelState createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> with TickerProviderStateMixin {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();

  bool _showToast;
  bool _showScrollHead;
  bool _showSearchToolbar;

  // Ensure the entry history of text search.
  LocalHistoryEntry _localHistoryEntry;
  PageController _controller;
  List data;
  var quote;
  List<int> verticalData = [];
  List<int> horizontalData = [];
  final int increment = 10;
  bool isLoadingVertical = false;
  bool isLoadingHorizontal = false;

  @override
  void initState() {
    _showToast = false;
    _showScrollHead = true;
    _showSearchToolbar = false;
    super.initState();
    _controller = PageController();
  }

  Future loadMore() async {
    setState(() {
      isLoadingVertical = true;
    });
    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));
    verticalData.addAll(
        List.generate(increment, (index) => verticalData.length + index));
    setState(() {
      isLoadingVertical = false;
    });
  }

  void _ensureHistoryEntry() {
    if (_localHistoryEntry == null) {
      final ModalRoute<dynamic> route = ModalRoute.of(context);
      if (route != null) {
        _localHistoryEntry =
            LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_localHistoryEntry);
      }
    }
  }

  void _handleHistoryEntryRemoved() {
    _textSearchKey?.currentState?.clearSearch();
    setState(() {
      _showSearchToolbar = false;
      _localHistoryEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final ar = locale.languageCode == 'ar';
    if (DeviceOS.isDesktopOrWeb && isDesktop ||
        (context.isTablet && DeviceOS.isMobile)) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Get.theme.primaryColorDark,
                    Get.theme.backgroundColor
                  ],
                  tileMode: TileMode.repeated,
                  begin: ar ? Alignment.topRight : Alignment.topLeft,
                  end: ar ? Alignment.bottomLeft : Alignment.bottomRight),
            ),
            child: Stack(
              children: [
                Container(
                  height: Get.size.height,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Get.theme.primaryColorDark,
                          Get.theme.backgroundColor
                        ],
                        begin: ar ? Alignment.topRight : Alignment.topLeft,
                        end: ar ? Alignment.bottomLeft : Alignment.bottomRight),
                  ),
                ),
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    S.current.salam,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      shadows: [
                        Shadow(
                          color: Colors.transparent,
                          blurRadius: 10.0,
                          offset: Offset(3.0, 3.0),
                        ),
                        Shadow(
                          color: Colors.transparent,
                          blurRadius: 10.0,
                          offset: Offset(-2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Get.theme.primaryColorDark,
                            Get.theme.backgroundColor
                          ],
                          begin: ar ? Alignment.topRight : Alignment.topLeft,
                          end: ar
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight),
                      color: Color(0xFFFAFAFC).withOpacity(0.1),
                      // border: Border.all(color: Color(4278190080)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.quizDirection,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 260.0, left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Get.theme.primaryColorDark,
                      //     Get.theme.backgroundColor
                      //   ],
                      //   begin: ar
                      //       ? Alignment.topRight
                      //       : Alignment.topLeft,
                      //   end: ar
                      //       ? Alignment.bottomRight
                      //       : Alignment.bottomLeft,
                      // ),
                      color: Colors.transparent,
                      // border: Border.all(color: Color(0xFFFAFAFC)),
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 50,
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 50,
                          childAspectRatio: 2.4),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        buildCard('Tawheed', S.current.tawheed),
                        buildCard('Prayer', S.current.prayer),
                        buildCard('Fast', S.current.swaum),
                        buildCard('Quran', S.current.quran),
                        buildCard('Charity', S.current.zakkah),
                        buildCard('Hajj', S.current.hajj),
                        buildCard('Marriage', S.current.nikkah),
                        buildCard('History', S.current.history),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return PageView(controller: _controller, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.isTablet ? 30 : 20,
                      vertical: context.isTablet ? 20 : 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        leading: IconButton(
                          icon: FaIcon(
                              FontAwesomeIcons.bookOpen..matchTextDirection),
                          splashRadius: 20,
                          onPressed: () => Get.to(() => Succinct()),
                        ),
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.black),
                        backgroundColor: Colors.transparent,
                        actions: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.cog),
                            splashRadius: 20,
                            onPressed: () => Get.to(() => Settings()),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        S.current.salam,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        S.current.quizDirection,
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.isTablet ? 30 : 20,
                      vertical: context.isTablet ? 20 : 10),
                  child: LazyLoadScrollView(
                    onEndOfPage: () => loadMore(),
                    child: ListView(
                      children: [
                        buildCard('Tawheed', S.current.tawheed),
                        buildCard('Prayer', S.current.prayer),
                        buildCard('Fast', S.current.swaum),
                        buildCard('Qur\'an', S.current.quran),
                        buildCard('Charity', S.current.zakkah),
                        buildCard('Hajj', S.current.hajj),
                        buildCard('Marriage', S.current.nikkah),
                        buildCard('History', S.current.history),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: StretchButton(
              text: "Cooming Soon In Sha Allah", primary: false, onTap: () {}),
        ),
        DeviceOS.isMobile
            ? Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: _showSearchToolbar
                    ? AppBar(
                        elevation: 0,
                        flexibleSpace: SafeArea(
                          child: SearchToolbar(
                            key: _textSearchKey,
                            showTooltip: true,
                            controller: _pdfViewerController,
                            onTap: (Object toolbarItem) async {
                              if (toolbarItem.toString() == 'Cancel Search') {
                                setState(() {
                                  _showSearchToolbar = false;
                                  _showScrollHead = true;
                                  if (Navigator.canPop(context)) {
                                    Navigator.maybePop(context);
                                  }
                                });
                              }
                              if (toolbarItem.toString() == 'onSubmit') {
                                setState(() {
                                  _showToast = true;
                                });
                                await Future.delayed(Duration(seconds: 2));
                                setState(() {
                                  _showToast = false;
                                });
                              }
                            },
                          ),
                        ),
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                      )
                    : AppBar(
                        elevation: 0,
                        title: Text(
                          'My Ramadhan Planner',
                          style: TextStyle(color: Colors.black87),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(FontAwesomeIcons.search),
                            onPressed: () {
                              setState(() {
                                _showScrollHead = false;
                                _showSearchToolbar = true;
                                _ensureHistoryEntry();
                              });
                            },
                          ),
                        ],
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                      ),
                body: Stack(
                  children: [
                    SfPdfViewer.asset(
                      'assets/daily/MyRamadanPlanner.pdf',
                      controller: _pdfViewerController,
                      canShowScrollHead: _showScrollHead,
                    ),
                    Visibility(
                      visible: _showToast,
                      child: Align(
                        alignment: Alignment.center,
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 15, top: 7, right: 15, bottom: 7),
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: Text(
                                'No matches found',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Offstage(child: Container(),offstage: true)
      ]);
    }
  }

  Widget buildCard(String name, String display) {
    final isDesktop = isDisplayDesktop(context);
    Locale locale = Localizations.localeOf(context);
    final colorScheme = Get.theme.colorScheme;
    final ar = locale.languageCode == 'ar';
    final size = context.mediaQuery.size;
    return WidgetAnimator(
      AnimContainer(
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Positioned(
                bottom: isDesktop ? size.height * 0.097 : size.height * 0.1,
                right: ar
                    ? isDesktop
                        ? width * 0.15
                        : size.width * 0.55
                    : 0,
                left: ar
                    ? 0
                    : isDesktop
                        ? width * 0.15
                        : size.width * 0.55,
                child: Container(
                  height: isDesktop ? size.height * 0.9 : size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor.withOpacity(0.03),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight:
                            ar ? Radius.elliptical(50, 110) : Radius.zero,
                        bottomLeft:
                            ar ? Radius.zero : Radius.elliptical(50, 110)),
                  ),
                ),
              ),
              Positioned(
                top: -size.height * 0.08,
                left: ar
                    ? isDesktop
                        ? size.width * 0.05
                        : size.width * 0.43
                    : 0,
                right: ar
                    ? 0
                    : isDesktop
                        ? size.width * 0.05
                        : size.width * 0.43,
                child: Container(
                  height: size.height * 0.165,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft:
                            ar ? Radius.elliptical(50, 120) : Radius.zero,
                        bottomRight:
                            ar ? Radius.zero : Radius.elliptical(50, 120)),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).accentColor,
                        Theme.of(context).backgroundColor
                      ],
                      tileMode: TileMode.mirror,
                      begin: !ar ? Alignment.topLeft : Alignment.topRight,
                      end: !ar ? Alignment.bottomRight : Alignment.bottomLeft,
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: isDesktop ? size.height * 0.098 : -size.height * 0.065,
                left: ar
                    ? isDesktop
                        ? size.width * 0.05
                        : size.width * 0.35
                    : 0,
                right: ar
                    ? 0
                    : isDesktop
                        ? size.width * 0.05
                        : size.width * 0.35,
                child: Container(
                  height: size.height * 0.175,
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor.withOpacity(0.04),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft:
                            ar ? Radius.elliptical(50, 110) : Radius.zero,
                        bottomRight:
                            ar ? Radius.zero : Radius.elliptical(50, 121)),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(20),
                enableFeedback: true,
                trailing: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: colorScheme.secondary),
                  child: IconButton(
                    icon: FaIcon(
                      ar
                          ? PixIcon.typcn_chevron_left
                          : PixIcon.typcn_chevron_right,
                      color: colorScheme.surface,
                    ),
                    splashRadius: isDesktop ? 20 : 30,
                    onPressed: () {},
                    // onPressed: () => isDesktop
                    //     ? Get.dialog(FetchQuestions(name: name))
                    //     : Get.to(FetchQuestions(name: name)),
                  ),
                ),
                title: Text(
                  display,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,  fontFamily: 'Quattrocento'),
                ),
                tileColor: Theme.of(context).hoverColor,
              ),
              Positioned(
                top: isDesktop ? size.height * 0.098 : size.height * 0.1,
                left: ar
                    ? 0
                    : isDesktop
                        ? size.width * 0.16
                        : size.width * 0.55,
                right: ar
                    ? isDesktop
                        ? size.width * 0.16
                        : size.width * 0.55
                    : 0,
                child: Container(
                  height: size.height * 0.175,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: ar ? Radius.zero : Radius.elliptical(50, 20),
                          topRight:
                              ar ? Radius.elliptical(50, 20) : Radius.zero),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).backgroundColor,
                          Theme.of(context).accentColor
                        ],
                        tileMode: TileMode.mirror,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                      shape: BoxShape.rectangle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
