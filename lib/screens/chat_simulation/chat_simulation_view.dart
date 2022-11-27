import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/screens/chat_simulation/chat_simulation_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

import 'forms/SocialDemographicForm.dart';

class ChatSimulationScreen extends StatelessWidget {
  ChatSimulationScreen({super.key});

  final _controller = Get.put(ChatSimulationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chatScreenAppBar(),
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 120,
            ),
            child: Obx(() => ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    controller: _controller.listController,
                    itemCount: _controller.sentMessages.length,
                    itemBuilder: (context, index) =>
                        _chatBubble(_controller.sentMessages[index]),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              color: Colors.grey[300],
              child: VPTextField(
                text: "Hastayla iletişime geçin",
                controller: _controller.chatController,
                icon: Icons.sms,
                isObscured: false,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(right: 20, bottom: 50),
              child: FloatingActionButton(
                onPressed: () => _controller.sendMessage(),
                backgroundColor: VPColors.primaryColor,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SlidingUpPanel(
              collapsed: Container(
                alignment: Alignment.center,
                child: const Divider(
                  color: VPColors.primaryColor,
                  thickness: 3,
                  indent: 100,
                  endIndent: 100,
                ),
              ),
              minHeight: Get.size.height * .04,
              maxHeight: Get.size.height * .9,
              panel: DefaultTabController(
                length: 4,
                child: Scaffold(
                    body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: const [
                      Align(
                        alignment: Alignment.topCenter,
                        child: TabBar(
                          indicatorColor: VPColors.primaryColor,
                          tabs: [
                            Tab(
                              child: Text("Form-1"),
                            ),
                            Tab(
                              child: Text("Form-2"),
                            ),
                            Tab(
                              child: Text("Form-3"),
                            ),
                            Tab(
                              child: Text("Form-4"),
                            ),
                          ],
                        ),
                      ),
                      TabBarView(children: [
                        Center(child:  SocialDemographicForm()),
                        Center(child: Text("Form-2 burada gözükecek.")),
                        Center(child: Text("Form-3 burada gözükecek.")),
                        Center(child: Text("Form-4 burada gözükecek.")),
                      ])
                    ],
                  ),
                )),
              )),
        ],
      ),
    );
  }

  AppBar _chatScreenAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: VPColors.primaryColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _controller.patientImage,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const VPCircularProgressIndicator(
                color: Colors.white,
              );
            } else {
              return Image.asset(
                  "assets/images/${_controller.patient?.gender}-1.png");
            }
          },
        ),
      ),
      title: Obx(() => Text("${_controller.appBarText}")),
    );
  }

  Widget _chatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
          alignment: message.sender == MessageSender.patient
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: message.sender == MessageSender.patient
                      ? VPColors.primaryColor
                      : Colors.white),
              width: Get.size.width / 2,
              child: Text(message.message,
                  style: Get.textTheme.caption?.copyWith(
                      color: message.sender == MessageSender.patient
                          ? Colors.white
                          : VPColors.primaryColor)))),
    );
  }
}
