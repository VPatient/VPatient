import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/screens/chat_simulation/chat_simulation_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

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
              bottom: 100,
            ),
            child: Obx(() => ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                      overscroll: false,
                      physics: const ClampingScrollPhysics()),
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
            if (!snapshot.hasData) {
              return const VPCircularProgressIndicator(
                color: Colors.white,
              );
            } else {
              return snapshot.data as Image;
            }
          },
        ),
      ),
      title: Obx(() => Text("${_controller.appBarText}")),
      actions: [
        IconButton(
            icon: const Icon(Icons.file_present, size: 30),
            onPressed: () => _controller.openPanel())
      ],
    );
  }

  Widget _chatBubble(ChatMessage message) {
    var alignmentLocation = message.sender == MessageSender.patient
        ? Alignment.centerLeft
        : Alignment.centerRight;

    var boxDecorationColor = message.sender == MessageSender.patient
        ? VPColors.primaryColor
        : Colors.white;

    var textDecorationColor = message.sender != MessageSender.patient
        ? VPColors.primaryColor
        : Colors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
          alignment: alignmentLocation,
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: boxDecorationColor),
              width: Get.size.width / 2,
              child: Text(message.text,
                  style: Get.textTheme.caption
                      ?.copyWith(color: textDecorationColor)))),
    );
  }
}
