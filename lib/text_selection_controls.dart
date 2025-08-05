import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Just big purple square selection handles. Looks great on any platform!
class PlatformAgnosticTextSelectionControls extends TextSelectionControls
    with TextSelectionHandleControls {
  static const double _kHandleSize = 22.0;

  @override
  Size getHandleSize(double textLineHeight) =>
      const Size(_kHandleSize, _kHandleSize);

  /// Builder for material-style text selection handles.
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textHeight, [
    VoidCallback? onTap,
  ]) {
    final Color handleColor = Color(0xffff00ff);
    final Widget handle = SizedBox(
      width: _kHandleSize,
      height: _kHandleSize,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: ColoredBox(color: handleColor),
      ),
      /*
      child: CustomPaint(
        painter: _TextSelectionHandlePainter(color: handleColor),
        child: GestureDetector(onTap: onTap, behavior: HitTestBehavior.translucent),
      ),
      */
    );

    // [handle] is a circle, with a rectangle in the top left quadrant of that
    // circle (an onion pointing to 10:30). We rotate [handle] to point
    // straight up or up-right depending on the handle type.
    return switch (type) {
      TextSelectionHandleType.left => Transform.rotate(
        angle: math.pi / 2.0,
        child: handle,
      ), // points up-right
      TextSelectionHandleType.right => handle, // points up-left
      TextSelectionHandleType.collapsed => Transform.rotate(
        angle: math.pi / 4.0,
        child: handle,
      ), // points up
    };
  }

  /// Gets anchor for material-style text selection handles.
  ///
  /// See [TextSelectionControls.getHandleAnchor].
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return switch (type) {
      TextSelectionHandleType.collapsed => const Offset(_kHandleSize / 2, -4),
      TextSelectionHandleType.left => const Offset(_kHandleSize, 0),
      TextSelectionHandleType.right => Offset.zero,
    };
  }
}
