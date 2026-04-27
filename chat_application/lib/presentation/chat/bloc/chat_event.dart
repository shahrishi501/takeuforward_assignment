import 'package:equatable/equatable.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/models/message_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChat extends ChatEvent {
  final Contact contact;

  const LoadChat(this.contact);

  @override
  List<Object?> get props => [contact.id];
}

class SendTextMessage extends ChatEvent {
  final String text;

  const SendTextMessage(this.text);

  @override
  List<Object?> get props => [text];
}

class SendAttachmentMessage extends ChatEvent {
  final String path;
  final String name;
  final MessageType type;

  const SendAttachmentMessage({
    required this.path,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [path, name, type];
}

// Internal — only dispatched by ChatBloc itself.
class UpdateMessageStatus extends ChatEvent {
  final String messageId;
  final MessageStatus status;

  const UpdateMessageStatus({required this.messageId, required this.status});

  @override
  List<Object?> get props => [messageId, status];
}

// Internal — triggers a simulated auto-reply.
class SimulateReply extends ChatEvent {
  const SimulateReply();
}
