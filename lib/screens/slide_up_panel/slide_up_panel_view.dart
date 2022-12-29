import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/screens/forms/blood_sugar_trace_form.dart';
import 'package:vpatient/screens/forms/fall_risk_scale_form.dart';
import 'package:vpatient/screens/forms/laboratory_results_form.dart';
import 'package:vpatient/screens/forms/medicines_form.dart';
import 'package:vpatient/screens/forms/norton_pressure_ulcer_form.dart';
import 'package:vpatient/screens/forms/pain_description_form.dart';
import 'package:vpatient/screens/forms/social_demographic_form/social_demographic_form.dart';
import 'package:vpatient/screens/forms/vital_sign_form.dart';
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
      maxHeight: Get.size.height * .9,
      panel: _slideUpPanelBody(),
    );
  }

  Widget _slideUpPanelBody() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            controller: _controller.tabController,
            indicatorColor: VPColors.primaryColor,
            tabs: const [
              Tab(
                child: Text("Sosyo-Demografik Form"),
              ),
              Tab(
                child: Text("Norton Basınç Ülseri Formu"),
              ),
              Tab(
                child: Text("Ağrı Niteliği Formu"),
              ),
              Tab(
                child: Text("Düşme Riski Ölçeği Formu"),
              ),      
              Tab(
                child: Text("Laboratuvar Sonuçları"),
              ),
              Tab(
                child: Text("Kan Şekeri Takibi"),
              ),
              Tab(
                child: Text("İlaçlar"),
              ),
              Tab(
                child: Text("Yaşamsal Bulgular"),
              )
            ],
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
            ]),
          )
        ],
      ),
    );
  }
}
