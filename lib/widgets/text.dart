import 'package:flutter/widgets.dart';

import '../theme.dart';

class MyText extends StatelessWidget {
  // TODO(justinmc): This was easy enough to write as-is, but in reality I would
  // need to pipe through all the other Text parameters, and any changes to Text
  // (admittedly rare) would silently make MyText out of date.
  const MyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color textColor = MyInheritedTheme.of(context).textColor;

    return Text(text, style: TextStyle(color: textColor));
  }
}
