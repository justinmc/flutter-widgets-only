import 'package:flutter/widgets.dart';

import '../text_selection_controls.dart';

class TextPage extends StatelessWidget {
  const TextPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page: $title'),
          SizedBox(height: 64.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
          SizedBox(height: 64.0),
          SelectableRegion(
            selectionControls: PlatformAgnosticTextSelectionControls(),
            contextMenuBuilder:
                (
                  BuildContext context,
                  SelectableRegionState selectableRegionState,
                ) {
                  /*
                  return AdaptiveTextSelectionToolbar.selectableRegion(
                    selectableRegionState: selectableRegionState,
                  );
                  */
                  return GestureDetector(
                    onTap: () {
                      selectableRegionState.hideToolbar();
                    },
                    child: Text('I am a context menu.'),
                  );
                },
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
          ),
        ],
      ),
    );
  }
}
