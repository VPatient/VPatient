import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class VPTextField extends StatelessWidget {
  const VPTextField(
      {Key? key,
      required TextEditingController controller,
      required isObscured,
      icon,
      required text,
      required keyboardType})
      : _controller = controller,
        _isObscured = isObscured,
        _icon = icon,
        _text = text,
        _keyboardType = keyboardType,
        super(key: key);

  final TextEditingController _controller;
  final bool _isObscured;
  final IconData? _icon;
  final String _text;
  final TextInputType _keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextField(
        keyboardType: _keyboardType,
        style: Theme.of(context).textTheme.bodyText1,
        obscureText: _isObscured,
        controller: _controller,
        cursorColor: VPColors.primaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            icon: Icon(
              _icon,
              color: VPColors.primaryColor,
            ),
            hintText: _text,
            hintStyle: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}

class VpTextField extends StatefulWidget {
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
          obscureText: true,
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

/***
 * enabledBorder: const OutlineInputBorder(
    borderSide:
    BorderSide(width: 3, color: VPColors.primaryColor)),
    hintStyle: Theme.of(context).textTheme.bodyText1
 */
