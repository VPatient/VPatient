import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class VPTextField extends StatelessWidget {
  const VPTextField(
      {Key? key,
      required TextEditingController controller,
      isObscured = false,
      icon,
      leadWidget,
      trailWidget,
      enabled = true,
      maxLines = 1,
      required text,
      required keyboardType})
      : _controller = controller,
        _isObscured = isObscured,
        _leadWidget = leadWidget,
        _trailWidget = trailWidget,
        _isEnabled = enabled,
        _text = text,
        _icon = icon,
        _maxLines = maxLines,
        _keyboardType = keyboardType,
        super(key: key);

  final TextEditingController _controller;
  final bool _isObscured;
  final String _text;
  final IconData? _icon;
  final TextInputType _keyboardType;
  final bool _isEnabled;
  final int _maxLines;

  final Widget? _leadWidget;
  final Widget? _trailWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _leadWidget ?? const SizedBox(width: 15),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  minLines: 1,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  enabled: _isEnabled,
                  keyboardType: _keyboardType,
                  style: Theme.of(context).textTheme.bodyText1,
                  obscureText: _isObscured,
                  controller: _controller,
                  cursorColor: VPColors.primaryColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      icon: Icon(_icon,
                          color: VPColors.primaryColor,
                          size: _icon == null ? 0 : 24),
                      hintText: _text,
                      hintStyle: Theme.of(context).textTheme.bodyText1),
                ),
              ),
            ),
            _trailWidget ?? Container()
          ]),
    );
  }
}

class VPTextFieldOutline extends StatelessWidget {
  const VPTextFieldOutline(
      {Key? key,
      required TextEditingController controller,
      isObscured = false,
      icon,
      enabled = true,
      maxLines = 1,
      required text,
      required keyboardType})
      : _controller = controller,
        _isObscured = isObscured,
        _isEnabled = enabled,
        _text = text,
        _icon = icon,
        _maxLines = maxLines,
        _keyboardType = keyboardType,
        super(key: key);

  final TextEditingController _controller;
  final bool _isObscured;
  final String _text;
  final IconData? _icon;
  final TextInputType _keyboardType;
  final bool _isEnabled;
  final int _maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        maxLines: _maxLines,
        textAlign: TextAlign.start,
        enabled: _isEnabled,
        keyboardType: _keyboardType,
        style: Theme.of(context).textTheme.bodyText1,
        obscureText: _isObscured,
        controller: _controller,
        cursorColor: VPColors.primaryColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: VPColors.primaryColor)),
          floatingLabelStyle: const TextStyle(color: VPColors.primaryColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          icon: Icon(_icon,
              color: VPColors.primaryColor, size: _icon == null ? 0 : 24),
          labelText: _text,
        ),
      ),
    );
  }
}
