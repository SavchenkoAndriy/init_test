import 'package:flutter/material.dart';

abstract class InputManager {
  InputManager(
    this.initialValue, {
    required this.errorColor,
    required this.inputColor,
    required this.textColor,
    required this.keyboardType,
    required this.labelText,
    this.borderColor,
    this.nextFocus,
    this.prefIcon,
    this.minLines = 1,
    this.maxLines = 1,
    this.autofillHints,
    this.textCapitalization,
    this.textInputAction,
    this.onSubmitted,
    this.sufIcon,
    this.obscureText = false,
    this.iconColor = Colors.blue,
  });

  final String? initialValue;
  final String labelText;
  final FocusNode? nextFocus;
  final Widget? prefIcon;
  final Widget? sufIcon;
  final Color errorColor;
  final Color inputColor;
  final Color textColor;
  final Color? borderColor;
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final void Function()? onSubmitted;
  final bool obscureText;
  final Color iconColor;
  bool hasError = false;

  dynamic get value;

  bool get isEmpty;

  void dispose();

  void requestNextFocus(BuildContext context);

  void clean();

  Color get currentColor => hasError ? errorColor : inputColor;

  Color get currentBorderColor => hasError ? errorColor : borderColor ?? inputColor;

  Color get currentTextColor => hasError ? errorColor : textColor;

  void addError() => hasError = true;

  void removeError() => hasError = false;

  bool hideInputValue = true;
}

class TextInputManager extends InputManager {
  TextInputManager(
    String initialValue, {
    required String labelText,
    FocusNode? nextFocus,
    Widget? prefIcon,
    TextInputType keyboardType = TextInputType.text,
    int minLines = 1,
    int maxLines = 1,
    Color errorColor = Colors.red,
    Color inputColor = Colors.grey,
    Color textColor = Colors.black,
    List<String>? autofillHints,
    Color? borderColor,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    void Function()? onSubmitted,
    bool obscureText = false,
    Widget? sufIcon,
    Color iconColor = Colors.lightBlue,
  })  : controller = TextEditingController(text: initialValue),
        super(
          initialValue,
          nextFocus: nextFocus,
          labelText: labelText,
          prefIcon: prefIcon,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          errorColor: errorColor,
          inputColor: inputColor,
          textColor: textColor,
          borderColor: borderColor,
          autofillHints: autofillHints,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          obscureText: obscureText,
          sufIcon: sufIcon,
          iconColor: iconColor,
        );

  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  @override
  String get value => controller.text;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }

  @override
  bool get isEmpty => controller.text.isEmpty;

  @override
  void requestNextFocus(BuildContext context) {
    if (controller.text == '' && nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  @override
  void clean() => controller.text = '';
}

class SelectorInputManager extends InputManager {
  SelectorInputManager(
    String? initialValue, {
    required this.options,
    required String labelText,
    FocusNode? nextFocus,
    Widget? prefIcon,
    TextInputType keyboardType = TextInputType.text,
    Color errorColor = Colors.red,
    Color inputColor = Colors.grey,
    Color textColor = Colors.black,
    Color? borderColor,
  })  : _value = initialValue,
        super(
          initialValue,
          nextFocus: nextFocus,
          labelText: labelText,
          prefIcon: prefIcon,
          keyboardType: keyboardType,
          errorColor: errorColor,
          inputColor: inputColor,
          textColor: textColor,
          borderColor: borderColor,
        );

  List<String> options = <String>[];

  String? _value;
  final FocusNode _focusNode = FocusNode();

  @override
  String? get value => _value;

  @override
  bool get isEmpty => _value == '' || _value == null;

  set value(String? value) => _value = value;

  @override
  void dispose() => _focusNode.dispose();

  @override
  void clean() => value = null;

  @override
  void requestNextFocus(BuildContext context) {
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
