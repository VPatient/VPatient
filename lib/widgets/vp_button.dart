import 'package:flutter/material.dart';

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
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(_bgColor)),
            onPressed: _function,
            child: Text(_text,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: _textColor))),
      ),
    );
  }
}
