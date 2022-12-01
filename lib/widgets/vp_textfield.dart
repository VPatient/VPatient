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
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    icon: Icon(_icon,
                        color: VPColors.primaryColor,
                        size: _icon == null ? 0 : 24),
                    hintText: _text,
                    hintStyle: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            _trailWidget ?? Container()
          ]),
    );
  }
}

/*class VpTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hint;

  const VpTextField({Key? key, required this.hint, required this.keyboardType})
      : super(key: key);

  @override
  State<VpTextField> createState() => _VpTextFieldState();
}

class _VpTextFieldState extends State<VpTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextField(
        keyboardType: widget.keyboardType,
        style: Theme.of(context).textTheme.bodyText1,
        obscureText: false,
        controller: _controller,
        cursorColor: VPColors.primaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
*/