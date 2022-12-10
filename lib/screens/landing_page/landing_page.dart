import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/landing_page/landing_page_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final _controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
            flex: 9,
            child: PageView(
              controller: _controller.controller,
              children: [page(1), page(2), page(3), page(4), page(5)],
            )),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: VPButton(
                    bgColor: VPColors.primaryColor,
                    text: "<",
                    textColor: Colors.white,
                    function: () => _controller.navigateToPreviousPage(),
                    width: .8),
              ),
              Obx(
                () => Visibility(
                  visible: _controller.isNextButtonVisible,
                  child: Expanded(
                    child: VPButton(
                        bgColor: VPColors.primaryColor,
                        text: ">",
                        textColor: Colors.white,
                        function: () => _controller.navigateToNextPage(),
                        width: .8),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget page(int page) {
    return Center(child: Text("Sayfa $page"));
  }
}
