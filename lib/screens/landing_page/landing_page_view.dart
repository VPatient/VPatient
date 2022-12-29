import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/landing_page/landing_page_controller.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final _controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _renderPages(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => TextButton(
                        onPressed: _controller.previousButtonState
                            ? null
                            : () => _controller.navigateToPreviousPage(),
                        child: Text(
                            _controller.previousButtonState ? "" : "Geri",
                            style: Get.textTheme.headline6))),
                    Obx(() => TextButton(
                        onPressed: () => _controller.navigateToNextPage(),
                        child: Text(
                            _controller.nextButtonState ? "Anladım" : "İleri",
                            style: Get.textTheme.headline6)))
                  ],
                ),
              ),
            )
          ],
        ));
  }

  PageView _renderPages() {
    return PageView.builder(
      controller: _controller.pageController,
      itemCount: 6,
      onPageChanged: (value) {
        _controller.setPreviousButtonState = value == 0;
        _controller.setNextButtonState = value == 5;
      },
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(top: 56, bottom: 64),
            child: Image.asset("assets/images/landing_page/${index + 1}.png"));
      },
    );
  }
}
