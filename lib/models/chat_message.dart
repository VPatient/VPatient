import 'dart:convert';

import 'package:vpatient/utils/message_sender.dart';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.patient,
    required this.sequence,
    required this.text,
    required this.sender,
    required this.action,
    required this.date,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String patient;
  int sequence;
  String text;
  MessageSender sender;
  bool action;
  DateTime date;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["_id"],
        patient: json["patient"],
        sequence: json["sequence"],
        text: json["text"],
        sender: json["reply"] ? MessageSender.patient : MessageSender.nurse,
        action: json["action"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "patient": patient,
        "sequence": sequence,
        "text": text,
        "reply": sender == MessageSender.nurse,
        "action": action,
        "date": date.toIso8601String(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
