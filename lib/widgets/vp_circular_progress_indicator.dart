import 'package:flutter/material.dart';

class VPCircularProgressIndicator extends StatelessWidget {
  const VPCircularProgressIndicator({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
