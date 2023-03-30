import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:vpatient/style/colors.dart';

import 'life_activity_diagnostic_form_controller.dart';

class LifeActivityDiagnosisForm extends StatelessWidget {
  LifeActivityDiagnosisForm({super.key});

  final _controller = Get.put(LifeActivityDiagnosisFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: VPColors.secondaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: VPColors.secondaryColor),
            isScrollable: true,
            controller: _controller.tabController,
            indicatorColor: VPColors.secondaryColor,
            tabs: _controller.formList.map((e) => VPTab(e)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller.tabController,
            children: _controller.formList.map((e) {
              int index = _controller.formList.indexOf(e);
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: FormBuilder(
                  submitButtonText: "Gönder",
                  submitTextDecoration: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                  submitButtonDecoration: BoxDecoration(
                      color: VPColors.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  initialData: _controller.formData[index],
                  index: 0,
                  onSubmit: (val) {
                    for (var element in val.data!.first.questions!) {
                      if (element.answer != element.correct_answer) {
                        print("error");
                        Get.snackbar(
                          "${element.title} is not correct",
                          '${element.correct_answer} is the correct answer',
                          snackStyle: SnackStyle.FLOATING,
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                    }

                    Get.snackbar(
                      "FORM VALIDATED",
                      "Form validated successfully",
                      snackStyle: SnackStyle.FLOATING,
                      duration: const Duration(seconds: 3),
                      backgroundColor: VPColors.primaryColor,
                      colorText: Colors.white,
                    );
                  },
                ),
              );
            }).toList(),
          ),
        )
      ],
    ));
  }

  Tab VPTab(String title) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: VPColors.secondaryColor, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }
}
