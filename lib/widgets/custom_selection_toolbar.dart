import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:islam_made_easy/views/QnA/qna.dart';

typedef OffsetValue = void Function(int start, int end);

// todo: Find a clean way to get data from clipboard
class CustomTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  CustomTextSelectionControls({this.customButton});

  final OffsetValue? customButton;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            startTextSelectionPoint.point.dy -
            textLineHeight -
            _kToolbarContentDistance);
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );

    return CustomTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleShare: () async {
        canCopy(delegate) ? () => handleCopy(delegate, clipboardStatus) : null;
        // Map<String, dynamic> result = await SystemChannels.platform.invokeMethod('Clipboard.getData');
        // delegate.userUpdateTextEditingValue(
        //     delegate.textEditingValue, SelectionChangedCause.tap);
        customBottomSheet(context, delegate.textEditingValue.text);
        // delegate.hideToolbar();
      },
      handleCopy: canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : null,
      customButton: () {
        customButton!(delegate.textEditingValue.selection.start,
            delegate.textEditingValue.selection.end);
        delegate.textEditingValue.copyWith(
          selection: TextSelection.collapsed(
            offset: delegate.textEditingValue.selection.baseOffset,
          ),
        );
        delegate.hideToolbar();
      },
      handleCut:
          canCut(delegate) ? () => handleCut(delegate, clipboardStatus) : null,
      handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
      handleSelectAll:
          canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
    );
  }
}

Future<String?> getClipBoardData() async {
  ClipboardData data = await (Clipboard.getData(Clipboard.kTextPlain)
      as FutureOr<ClipboardData>);
  return data.text;
}

Future<void> customBottomSheet(BuildContext context, data) async {
  final size = MediaQuery.of(context).size;
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
            children: [
              Container(
                height: size.height * .5,
                width: size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              Container(
                  height: size.height * .25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...events.map((event) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(16),
                                      right: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      'assets/images/${event.assetName}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () => Get.back(),
                            child: Text('Close'),
                            shape: StadiumBorder(),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Text('Share'),
                            shape: StadiumBorder(),
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        );
      });
}

final List<Event> events = [
  Event('logo.png'),
  Event('ctr.png'),
  Event('Logo3.png'),
  Event('logo.png'),
];

class Event {
  final String assetName;

  Event(this.assetName);
}

class CustomTextSelectionToolbar extends StatefulWidget {
  const CustomTextSelectionToolbar({
    Key? key,
    this.anchorAbove,
    this.anchorBelow,
    this.clipboardStatus,
    this.handleCopy,
    this.handleCut,
    this.handlePaste,
    this.handleSelectAll,
    this.handleShare,
    this.customButton,
  }) : super(key: key);

  final Offset? anchorAbove, anchorBelow;
  final ClipboardStatusNotifier? clipboardStatus;
  final VoidCallback? handleCopy,
      handleCut,
      handlePaste,
      handleSelectAll,
      handleShare,
      customButton;

  @override
  CustomTextSelectionToolbarState createState() =>
      CustomTextSelectionToolbarState();
}

class CustomTextSelectionToolbarState
    extends State<CustomTextSelectionToolbar> {
  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    widget.clipboardStatus!.addListener(_onChangedClipboardStatus);
    widget.clipboardStatus!.update();
  }

  @override
  void didUpdateWidget(CustomTextSelectionToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clipboardStatus != oldWidget.clipboardStatus) {
      widget.clipboardStatus!.addListener(_onChangedClipboardStatus);
      oldWidget.clipboardStatus!.removeListener(_onChangedClipboardStatus);
    }
    widget.clipboardStatus!.update();
  }

  @override
  void dispose() {
    super.dispose();
    if (!widget.clipboardStatus!.disposed)
      widget.clipboardStatus!.removeListener(_onChangedClipboardStatus);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations label = MaterialLocalizations.of(context);

    final List<_ItemData> itemData = <_ItemData>[
      _ItemData(onPressed: widget.handleShare, label: S.current.share),
      if (widget.handleCut != null)
        _ItemData(label: label.cutButtonLabel, onPressed: widget.handleCut),
      if (widget.handleCopy != null)
        _ItemData(label: label.copyButtonLabel, onPressed: widget.handleCopy),
      if (widget.handlePaste != null &&
          widget.clipboardStatus!.value == ClipboardStatus.pasteable)
        _ItemData(label: label.pasteButtonLabel, onPressed: widget.handlePaste),
      if (widget.handleSelectAll != null)
        _ItemData(
          label: label.selectAllButtonLabel,
          onPressed: widget.handleSelectAll,
        ),
      _ItemData(onPressed: widget.customButton, label: 'Correction'),
    ];

    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: widget.anchorAbove!,
      anchorBelow: widget.anchorBelow!,
      toolbarBuilder: (BuildContext context, Widget child) {
        return Card(child: child);
      },
      children: itemData.map((_ItemData data) {
        return TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(
              childIndex++, itemData.length),
          onPressed: data.onPressed,
          child: Text(data.label!),
        );
      }).toList(),
    );
  }
}

class _ItemData {
  const _ItemData({this.label, this.onPressed});

  final String? label;
  final VoidCallback? onPressed;
}
