import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    required this.text,
    required this.onSubmit,
    this.lightBorder = false,
    Key? key,
  }) : super(key: key);

  final String text;
  final Future<void> Function() onSubmit;
  final bool lightBorder;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> with TickerProviderStateMixin {
  bool _isProgress = false;

  Future<void> _onSubmit() async {
    if (_isProgress) {
      return;
    }
    setState(() => _isProgress = true);
    await widget.onSubmit();
    setState(() => _isProgress = false);
  }

  Color get _getBorderColor {
    return widget.lightBorder ? Colors.lightBlue : Colors.blue.withOpacity(.5);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashColor: Colors.lightBlue,
        borderRadius: BorderRadius.circular(10),
        onTap: _onSubmit,
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _getBorderColor),
          ),
          child: Align(
            child: _isProgress
                ? const CircularProgressIndicator(color: Colors.blue)
                : Text(widget.text, style: const TextStyle(color: Colors.blue, fontSize: 17)),
          ),
        ),
      ),
    );
  }
}
