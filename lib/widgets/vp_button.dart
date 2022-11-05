import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class VPButton extends StatelessWidget {
  const VPButton({
    Key? key,
    required bgColor,
    required text,
    required textColor,
    required function,
    required width,
  })  : _bgColor = bgColor,
        _text = text,
        _textColor = textColor,
        _function = function,
        _width = width,
        super(key: key);

  final Color _bgColor;
  final String _text;
  final Color _textColor;
  final VoidCallback _function;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: _width,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    side: BorderSide(
                        color: VPColors.vpGreen,
                        width: 1,
                        style: BorderStyle.solid))),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(16)),
                backgroundColor: MaterialStateProperty.all<Color>(_bgColor)),
            onPressed: _function,
            child:
                Text(_text, style: TextStyle(color: _textColor, fontSize: 20))),
      ),
    );
  }
}
