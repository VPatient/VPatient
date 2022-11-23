import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/patient_list/patient_list_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';
import 'package:vpatient/widgets/vp_patient_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PatientListScreen extends GetView {
  PatientListScreen({Key? key}) : super(key: key);

  final _controller = Get.put(PatientListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: _controller.patients,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const VPCircularProgressIndicator(
                    color: VPColors.primaryColor);
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 6,
                      child: CarouselSlider(
                        items: snapshot.data!
                            .map((e) => PatientCard(patient: e))
                            .toList(),
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) =>
                                _controller.setActivePage = index,
                            height: Get.size.height * .7),
                      ),
                    ),
                    Flexible(
                        flex: 1, child: _indicators(snapshot.data!.length)),
                    Flexible(
                      flex: 1,
                      child: VPButton(
                          bgColor: VPColors.primaryColor,
                          text: "Hasta Seç",
                          textColor: Colors.white,
                          function: () => _controller.selectPatient(),
                          width: 0.5),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  Obx _indicators(dataLength) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(dataLength, (index) {
            return Container(
              margin: const EdgeInsets.all(3),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: _controller.activePage.value == index
                      ? VPColors.primaryColor
                      : Colors.black12,
                  shape: BoxShape.circle),
            );
          }),
        ));
  }
}

/* 
PageView.builder(
                        onPageChanged: (page) =>
                            _controller.setActivePage = page,
                        controller: _controller.pageController,
                        itemCount: snapshot.data?.length,
                        pageSnapping: true,
                        itemBuilder: (context, index) {
                          return PatientCard(
                              patient: snapshot.data!.elementAt(index));
                        },
                      )
*/