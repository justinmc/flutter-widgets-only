import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// TODO(justinmc): Or this could be an InheritedModel.
class MyInheritedTheme extends InheritedWidget {
  const MyInheritedTheme({
    super.key,
    this.themeData = const MyThemeData(),
    required super.child,
  });

  final MyThemeData themeData;

  static MyThemeData of(BuildContext context) {
    final MyInheritedTheme? theme = context
        .dependOnInheritedWidgetOfExactType<MyInheritedTheme>();
    return theme?.themeData ?? MyThemeData();
  }

  @override
  bool updateShouldNotify(MyInheritedTheme old) => themeData != old.themeData;
}

class MyThemeData with Diagnosticable {
  const MyThemeData({this.textColor = _kDefaultTextColor});

  final Color textColor;

  static const Color _kDefaultTextColor = Color(0xffaaaaff);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ColorProperty('textColor', textColor, defaultValue: _kDefaultTextColor),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MyThemeData &&
            runtimeType == other.runtimeType &&
            textColor == other.textColor;
  }

  @override
  int get hashCode => textColor.hashCode;
}
