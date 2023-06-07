import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/models/grade.dart';
import 'package:vpatient/screens/chat_simulation/chat_simulation_view.dart';
import 'package:vpatient/screens/doctor_order/doctor_order_view.dart';
import 'package:vpatient/screens/home/home_controller.dart';
import 'package:vpatient/screens/landing_page/landing_page_view.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_view.dart';
import 'package:vpatient/screens/patient_list/patient_list_view.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/avatar_helper.dart';
import 'package:vpatient/utils/user_helper.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Sanal Hastam"),
        backgroundColor: VPColors.primaryColor,
        actions: [
          IconButton(
              onPressed: () => _controller.logOut(),
              icon: const Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CircleAvatar(
                maxRadius: 40,
                backgroundColor: VPColors.primaryColor,
                child: Text(
                  UserHelper.getFirstCharacters(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Hoşgeldin ${_controller.getUser().name}",
                style: Get.textTheme.headline6,
              ),
            ],
          ),
          FutureBuilder(
              future: _controller.getPatients(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const VPCircularProgressIndicator(
                      color: VPColors.primaryColor);
                } else {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!.isEmpty
                            ? "Daha önce tanı koyulan bir hasta yok."
                            : "Tanı Koyulan Hastalar",
                        style: Get.textTheme.headline6,
                      ),
                      snapshot.data!.isNotEmpty
                          ? CarouselSlider(
                              items: snapshot.data!
                                  .map((e) => _renderGradeCard(e))
                                  .toList(),
                              options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  height: Get.size.height * .5),
                            )
                          : Container()
                    ],
                  );
                }
              })), /*
          VPButton(
            bgColor: VPColors.primaryColor,
            text: "Yeni Hasta",
            textColor: Colors.white,
            width: .6,
            function: () {
              Get.to(() => PatientListScreen());
            },
          ),
          ElevatedButton(
            child: const Text("Hastaları Gör"),
            onPressed: () {
              Get.to(() => PatientListScreen());
            },
          ),
          ElevatedButton(
            child: const Text("Chat Ekranı"),
            onPressed: () {
              Get.to(() => ChatSimulationScreen());
            },
          ),
          ElevatedButton(
            child: const Text("Landing Page"),
            onPressed: () {
              Get.to(() => LandingPage());
            },
          ),
          ElevatedButton(
              child: const Text("Formlar"),
              onPressed: () => _controller.openPanel()),
          ElevatedButton(
              child: const Text("Hasta Tanısı"),
              onPressed: () => {Get.to(() => PatientDiagnosisScreen())}),
          ElevatedButton(
              child: const Text("Hekim Orderı"),
              onPressed: () => {Get.to(() => DoctorOrderPage())}),*/
        ],
      )),
    );
  }

  Widget _renderGradeCard(Grade grade) {
    return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                  color: VPColors.primaryColor)
            ],
            borderRadius: BorderRadius.circular(10),
            color: VPColors.primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 150, child: AvatarHelper.getAvatar(grade.patient)),
            Text(grade.patient.name,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Yaş",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("${grade.patient.age}",
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Divider(color: Colors.white, thickness: .75),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cinsiyet",
                          style: TextStyle(color: Colors.white)),
                      Text(grade.patient.gender,
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Divider(color: Colors.white, thickness: .75),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Puan", style: TextStyle(color: Colors.white)),
                      Text(grade.grade.toString(),
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
