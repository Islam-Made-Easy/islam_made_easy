import 'package:flutter/foundation.dart';

/// Using letter spacing in Flutter for Web can cause a performance drop,
/// see https://github.com/flutter/flutter/issues/51234.
double letterSpacingOrNone(double letterSpacing) => kIsWeb ? .0 : letterSpacing;
