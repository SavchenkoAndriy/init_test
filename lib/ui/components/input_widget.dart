import 'package:flutter/material.dart';

import '../../models/input_manager.dart';
import 'ink_well_without_glow.dart';

class InputWidget extends StatefulWidget {
  const InputWidget(
    this.manager, {
    this.onChange,
    this.withLabel = true,
    this.filled = false,
    this.padding,
    this.enabled = true,
    this.withCleanBtn = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final TextInputManager manager;
  final void Function(String?)? onChange;
  final bool withLabel;
  final bool filled;
  final EdgeInsets? padding;
  final bool enabled;
  final bool withCleanBtn;
  final VoidCallback? onTap;

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  void _onChanged(String value) {
    widget.manager.removeError();
    widget.onChange?.call(value);
  }

  void _clean() {
    widget.manager.clean();
    widget.onChange?.call(null);
  }

  void _actionWithRefresh(void Function()? action) {
    action?.call();
    setState(() {});
  }

  void _setHideValue() => widget.manager.hideInputValue = !widget.manager.hideInputValue;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.manager.controller,
      onSubmitted: (_) => _actionWithRefresh(widget.manager.onSubmitted),
      onChanged: (String v) => _actionWithRefresh(() => _onChanged(v)),
      onTap: () => _actionWithRefresh(widget.onTap),
      keyboardType: widget.manager.keyboardType,
      textCapitalization: widget.manager.textCapitalization!,
      textInputAction: widget.manager.textInputAction,
      focusNode: widget.manager.focusNode,
      showCursor: true,
      cursorColor: widget.manager.inputColor,
      style: TextStyle(fontSize: 17, color: widget.manager.textColor, fontWeight: FontWeight.w400),
      obscureText: widget.manager.obscureText ? widget.manager.hideInputValue : widget.manager.obscureText,
      maxLines: widget.manager.maxLines,
      minLines: widget.manager.minLines,
      decoration: InputDecoration(
        enabled: widget.enabled,
        alignLabelWithHint: widget.manager.maxLines > 1,
        floatingLabelBehavior: !widget.withLabel ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
        labelText: widget.withLabel ? widget.manager.labelText : null,
        hintText: !widget.withLabel ? widget.manager.labelText : null,
        prefixIcon: widget.manager.prefIcon != null
            ? Padding(padding: const EdgeInsets.only(left: 8), child: widget.manager.prefIcon)
            : null,
        suffixIconConstraints: const BoxConstraints(maxHeight: 40),
        suffixIcon: _buildSufIcon(),
        fillColor: Colors.white,
        filled: widget.filled,
        isDense: true,
        labelStyle: TextStyle(
          fontSize: 17,
          color: widget.manager.value.isEmpty ? widget.manager.inputColor : widget.manager.currentColor,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(fontSize: 17, color: widget.manager.currentColor, fontWeight: FontWeight.w400),
        border: _buildBorder(),
        errorBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        contentPadding: widget.padding,
      ),
      autofillHints: widget.manager.autofillHints,
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: widget.manager.currentBorderColor),
    );
  }

  Widget _buildSufIcon() {
    if (widget.withCleanBtn && widget.manager.value.isNotEmpty) {
      return InkWell(
        onTap: () => _actionWithRefresh(_clean),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: Icon(Icons.close, color: Colors.blue),
        ),
      );
    }
    if (widget.manager.sufIcon != null) {
      return Padding(padding: const EdgeInsets.only(right: 10), child: widget.manager.sufIcon);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (widget.manager.hasError) ...<Widget>[
          const Icon(Icons.warning, color: Colors.red),
          SizedBox(width: widget.manager.obscureText ? 5 : 10),
        ],
        if (widget.manager.obscureText)
          InkWellWithoutGlow(
            onTap: () => _actionWithRefresh(_setHideValue),
            child: Container(
              padding: EdgeInsets.all(widget.manager.hideInputValue ? 0 : 1.35),
              margin: const EdgeInsets.only(right: 10),
              color: Colors.transparent,
              height: 25,
              width: 25,
              child: Icon(
                widget.manager.hideInputValue ? Icons.hide_source : Icons.remove_red_eye_outlined,
                color: widget.manager.iconColor,
              ),
            ),
          )
        else
          const SizedBox(width: 0, height: 25)
      ],
    );
  }
}
