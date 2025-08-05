import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'pages/text_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyInheritedTheme(
      themeData: MyThemeData(textColor: Color(0xffffffaa)),
      child: WidgetsApp(
        title: 'Flutter Widgets Library Demo',
        color: Color(0xff00ff00),
        onGenerateRoute: (RouteSettings? settings) {
          return switch (settings?.name) {
            '/' => _WidgetsPageRoute(
              builder: (BuildContext context) => _MyHomePage(title: 'Home'),
            ),
            '/text' => _WidgetsPageRoute(
              builder: (BuildContext context) => TextPage(title: 'Text Page'),
            ),
            _ => _WidgetsPageRoute(
              builder: (BuildContext context) => _UnknownPage(),
            ),
          };
        },
      ),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({required this.title});

  final String title;

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times:',
            style: TextStyle(color: MyInheritedTheme.of(context).textColor),
          ),
          Text('$_counter'),
          GestureDetector(onTap: _incrementCounter, child: const Text('+1')),
          SizedBox(height: 64.0),
          EditableText(
            backgroundCursorColor: Color(0xff00ff00),
            controller: _controller,
            cursorColor: Color(0xff00ff00),
            style: TextStyle(),
            focusNode: _focusNode,
          ),
          SizedBox(height: 64.0),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/text');
            },
            child: const Text('Go to Text Page'),
          ),
        ],
      ),
    );
  }
}

class _UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('404'));
  }
}

class _WidgetsPageRoute<T> extends PageRoute<T> {
  /// Construct a _WidgetsPageRoute whose contents are defined by [builder].
  _WidgetsPageRoute({required this.builder}) {
    assert(opaque);
  }

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  @override
  final bool maintainState = true;

  @override
  Duration get transitionDuration => const Duration(microseconds: 300);

  @override
  Duration get reverseTransitionDuration => const Duration(microseconds: 300);

  @override
  TickerFuture didPush() {
    controller?.duration = transitionDuration;
    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    controller?.reverseDuration = reverseTransitionDuration;
    return super.didPop(result);
  }

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  DelegatedTransitionBuilder? get delegatedTransition => _delegatedTransition;

  // TODO(justinmc): Delegated transition does nothing now.
  static Widget? _delegatedTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    return child;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog,
    // or there is no matching transition to use.
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    final bool nextRouteIsNotFullscreen =
        (nextRoute is! PageRoute<T>) || !nextRoute.fullscreenDialog;

    // If the next route has a delegated transition, then this route is able to
    // use that delegated transition to smoothly sync with the next route's
    // transition.
    final bool nextRouteHasDelegatedTransition =
        nextRoute is ModalRoute<T> && nextRoute.delegatedTransition != null;

    // Otherwise if the next route has the same route transition mixin as this
    // one, then this route will already be synced with its transition.
    return nextRouteIsNotFullscreen &&
        ((nextRoute is _WidgetsPageRoute) || nextRouteHasDelegatedTransition);
  }

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
    // Suppress previous route from transitioning if this is a fullscreenDialog route.
    return previousRoute is PageRoute && !fullscreenDialog;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = builder(context);
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }

  // TODO(justinmc): No transition currently.
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
