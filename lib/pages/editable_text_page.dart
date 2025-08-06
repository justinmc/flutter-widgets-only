import 'package:flutter/widgets.dart';

import '../theme.dart';

class EditableTextPage extends StatefulWidget {
  const EditableTextPage({required this.title, super.key});

  final String title;

  @override
  State<EditableTextPage> createState() => _EditableTextPageState();
}

class _EditableTextPageState extends State<EditableTextPage> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _controller = TextEditingController(
    text: 'Type stuff here.',
  );

  @override
  Widget build(BuildContext context) {
    final Color textColor = MyInheritedTheme.of(context).textColor;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Page: ${widget.title}'),
          SizedBox(height: 64.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
          SizedBox(height: 64.0),
          EditableText(
            backgroundCursorColor: Color(0xff00ff00),
            controller: _controller,
            cursorColor: Color(0xff00ff00),
            style: TextStyle(color: textColor),
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}
