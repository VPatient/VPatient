import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/style/colors.dart';

import 'life_activity_diagnostic_form_controller.dart';

class LifeActivityDiagnosisForm extends StatelessWidget {
  LifeActivityDiagnosisForm({super.key});

  final _controller = Get.put(LifeActivityDiagnosisFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
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
              tabs: [
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.secondaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Form-1"),
                      ),
                    ),
                  ), 
                  Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.secondaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Form-2"),
                      ),
                    ),
                  ),                
              ],),
          ),
            Expanded(
            child: TabBarView(controller: _controller.tabController, children: [
              const Center(child: Text("Formlar Burada Gözükecek")),
              const Center(child: Text("Formlar Burada Gözükecek")),
            ]),
          )
        ],
      )
    );
  }
}