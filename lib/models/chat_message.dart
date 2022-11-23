import 'package:vpatient/utils/message_sender.dart';

class ChatMessage {
  final String message;
  final MessageSender sender;

  ChatMessage(this.message, this.sender);
}
