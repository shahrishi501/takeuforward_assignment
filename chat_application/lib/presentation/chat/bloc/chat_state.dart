import 'package:equatable/equatable.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/models/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final Contact contact;
  final List<Message> messages;

  const ChatLoaded({required this.contact, required this.messages});

  ChatLoaded copyWith({Contact? contact, List<Message>? messages}) {
    return ChatLoaded(
      contact: contact ?? this.contact,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [contact, messages];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
