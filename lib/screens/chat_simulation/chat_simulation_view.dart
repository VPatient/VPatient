import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/screens/chat_simulation/chat_simulation_controller.dart';
import 'package:vpatient/screens/chat_simulation/forms/norton_pressure_ulcer_form.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

import 'forms/pain_description_form.dart';
import 'forms/social_demographic_form.dart';

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
              bottom: 150,
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
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: Get.size.height * 0.055),
              width: double.infinity,
              color: Colors.grey[300],
              child: VPTextField(
                leadWidget: _dropDownMenu(),
                trailWidget: _sendButton(),
                text: "Hastayla iletişime geçin",
                controller: _controller.chatController,
                enabled: false,
                isObscured: false,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          SlidingUpPanel(
            controller: _controller.panelController,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            collapsed: Container(
              alignment: Alignment.center,
              child: const Divider(
                color: VPColors.primaryColor,
                thickness: 3,
                indent: 100,
                endIndent: 100,
              ),
            ),
            minHeight: Get.size.height * .05,
            maxHeight: Get.size.height * .9,
            panel: _slideUpPanelBody(),
          ),
        ],
      ),
    );
  }

  Padding _slideUpPanelBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26.0),
      child: Column(
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
                child: Text("Ağrı Niteliği Formu"),
              ),
              Tab(
                child: Text("Norton Basınç Ülseri Formu"),
              ),
              Tab(
                child: Text("Form-4"),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: _controller.tabController,
                children: const [
                  SocialDemographicForm(),
                  PainDescriptionForm(),
                  NortonPressureUlcerForm(),
                  Center(child: Text("Form-4 burada gözükecek.")),
                ]),
          )
        ],
      ),
    );
  }

  _sendButton() {
    return Obx(() => FloatingActionButton(
          onPressed: _controller.sendMessageStatus
              ? () => _controller.sendMessage()
              : null,
          backgroundColor: _controller.sendMessageStatus
              ? VPColors.primaryColor
              : Colors.grey,
          elevation: 0,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ));
  }

  Widget _dropDownMenu() {
    return Obx(() => PopupMenuButton<ChatMessage>(
          enabled: _controller.sendMessageStatus,
          color: Colors.white,
          tooltip: "Hastayla iletişime geçmek için tıklayın.",
          elevation: 0,
          constraints: BoxConstraints(minWidth: Get.size.width),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          offset: const Offset(0, 0),
          onSelected: (value) => _controller.chatController.text = value.text,
          icon: Icon(Icons.arrow_circle_up,
              color: _controller.sendMessageStatus
                  ? VPColors.primaryColor
                  : Colors.grey,
              size: 26),
          itemBuilder: (context) {
            return _controller.comboBoxMessages
                .map(
                  (e) => PopupMenuItem<ChatMessage>(
                      value: e,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Text(e.text,
                            overflow: TextOverflow.visible,
                            style: Get.theme.textTheme.caption
                                ?.copyWith(color: VPColors.primaryColor)),
                      )),
                )
                .toList();
          },
        ));
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
              child: Text(message.text,
                  style: Get.textTheme.caption?.copyWith(
                      color: message.sender == MessageSender.patient
                          ? Colors.white
                          : VPColors.primaryColor)))),
    );
  }
}
