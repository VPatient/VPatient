import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/screens/forms/blood_sugar_trace_form/blood_sugar_trace_form.dart';
import 'package:vpatient/screens/forms/fall_risk_form/fall_risk_scale_form.dart';
import 'package:vpatient/screens/forms/laboratory_results_form/laboratory_results_form.dart';
import 'package:vpatient/screens/forms/life_activity_diagnostic_form/life_activity_diagnostic_form.dart';
import 'package:vpatient/screens/forms/medicines_form/medicines_form.dart';
import 'package:vpatient/screens/forms/norton_pressure_ulcer_form/norton_pressure_ulcer_form.dart';
import 'package:vpatient/screens/forms/pain_description_form/pain_description_form.dart';
import 'package:vpatient/screens/forms/social_demographic_form/social_demographic_form.dart';
import 'package:vpatient/screens/forms/vital_sign_form/vital_sign_form.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/style/colors.dart';

class SlideUpPanelView extends StatelessWidget {
  SlideUpPanelView({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(SlideUpPanelController());

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _controller.panelController,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      minHeight: 0,
      maxHeight: Get.size.height * .8,
      panel: _slideUpPanelBody(),
    );
  }

  Widget _slideUpPanelBody() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: VPColors.primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: VPColors.primaryColor),
              isScrollable: true,
              controller: _controller.tabController,
              indicatorColor: VPColors.primaryColor,
              tabs: [
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Sosyo-Demografik Form"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Norton Basınç Ülseri Formu"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Ağrı Niteliği Formu"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Düşme Riski Ölçeği Formu"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Laboratuvar Sonuçları"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Kan Şekeri Takibi"),
                      ),
                    ),
                  ),Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("İlaçlar"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Yaşamsal Bulgular"),
                      ),
                    ),
                  ),
                Tab(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: VPColors.primaryColor, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Yaşam Aktivitesi Formları"),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _controller.tabController, children: [
              SocialDemographicForm(),
              NortonPressureUlcerForm(),
              PainDescriptionForm(),
              FallRiskScaleForm(),
              LaboratoryResultForm(),
              BloodSugarTraceForm(),
              MedicinesForm(),
              VitalSignForm(),
              LifeActivityDiagnosisForm()
            ]),
          )
        ],
      ),
    );
  }
}
