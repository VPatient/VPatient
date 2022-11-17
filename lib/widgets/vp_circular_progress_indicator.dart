import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class VPCircularProgressIndicator extends StatelessWidget {
  const VPCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: VPColors.primaryColor,
      ),
    );
  }
}
