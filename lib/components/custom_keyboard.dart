import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
      Key? key,
      required this.onTextInput,
      required this.onBackspace,
      required this.nextLine,
      required this.visiblekeypad,
      required this.loginPage,
      required this.convertPage,
      required this.transferPage
  }) : super(key: key);

  final ValueSetter<String> onTextInput;

  final VoidCallback onBackspace;
  final VoidCallback nextLine;
  final ValueSetter<bool> visiblekeypad;
  final bool convertPage;
  final bool transferPage;
  final bool loginPage;

  void _textInputHandler(String text) => onTextInput.call(text);

  void _keypad(bool text) => visiblekeypad.call(text);

  void _backspaceHandler() => onBackspace.call();
  void _nextLine() => nextLine.call();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30),
        height: MediaQuery.of(context).size.height * 0.35,
        child: convertPage == true || transferPage == true
            ? Column(
                children: [
                  buildRowOne(),
                  buildRowFour(),
                  buildRowThree(),
                  buildRowTwo(),
                  buildRowFive(),
                ],
              )
            : Column(
                children: [
                  buildRowOne(),
                  buildRowTwo(),
                  buildRowThree(),
                  buildRowFour(),
                  buildRowFive(),
                ],
              ));
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: <Widget>[
          IconText(
            iconName: 'Exit',
            isVisible: _keypad,
            flex: 1,
            next: () {},
            isLoginPage: true,
          ),
          Text(''),
          BackspaceKey(
            onBackspace: _backspaceHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '1',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '2',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '3',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '4',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '5',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '6',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '7',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '8',
            onTextInput: _textInputHandler,
          ),
          TextKey(
            text: '9',
            onTextInput: _textInputHandler,
          ),
        ],
      ),
    );
  }

  Expanded buildRowFive() {
    return Expanded(
      child: Row(
        children: [
          transferPage == true
              ? TextKey(
                  text: '.',
                  onTextInput: _textInputHandler,
                )
              : Text(''),
          TextKey(
            text: '0',
            onTextInput: _textInputHandler,
          ),
          IconText(
            iconName: 'next',
            isLoginPage: loginPage,
            isVisible: _keypad,
            next: _nextLine,
            flex: 1
          ),
        ],
      ),
    );
  }
}

// exit_to_app
// keyboard_return
class IconText extends StatelessWidget {
  const IconText({
      Key? key,
      this.flex = 1,
      required this.iconName,
      required this.isVisible,
      required this.next,
      required this.isLoginPage
  }) : super(key: key);

  final int flex;
  final String iconName;
  final ValueSetter<bool> isVisible;
  final VoidCallback next;
  final bool isLoginPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.grey,
          child: iconName == 'Exit'
              ? InkWell(
                  onTap: () {
                    print('Press Exit');
                    isVisible.call(false);
                  },
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.grey
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    print('Press Next');
                    // isLoginPage == true ? next?.call() : isVisible?.call(false);
                  },
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.keyboard_return,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class EmptyText extends StatelessWidget {
  EmptyText({
    Key? key,
    this.flex = 1,
  }) : super(key: key);

  final int flex;

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Material(
          child: SizedBox(),
        ),
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final ValueSetter<String>? onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.grey,
          child: InkWell(
            onTap: () {
              onTextInput?.call(text);
            },
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.grey
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackspaceKey extends StatefulWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int flex;

  @override
  _BackspaceKeyState createState() => _BackspaceKeyState();
}

class _BackspaceKeyState extends State<BackspaceKey> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.grey,
          child: InkWell(
            onTap: () {
              widget.onBackspace?.call();
            },
            child: Container(
              child: Center(
                child: Icon(
                  Icons.backspace,
                  color: Colors.grey
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}