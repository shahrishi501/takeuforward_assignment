import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  static const _uuid = Uuid();
  static const _autoReplies = [
    'Got it! 👍',
    'Sure, sounds good!',
    'Interesting! Tell me more 🤔',
    'Haha, that\'s great!',
    'Makes total sense 😊',
    'Alright, cool!',
    'Really? That\'s awesome! 🎉',
    'On it!',
    '👏 Nice one!',
    'Will do!',
    'Absolutely!',
    'Sounds great to me!',
  ];

  ChatBloc({required ChatRepository repository})
      : _repo = repository,
        super(const ChatInitial()) {
    on<LoadChat>(_onLoad);
    on<SendTextMessage>(_onSendText);
    on<SendAttachmentMessage>(_onSendAttachment);
    on<UpdateMessageStatus>(_onUpdateStatus);
    on<SimulateReply>(_onSimulateReply);
  }

  String get _contactId =>
      state is ChatLoaded ? (state as ChatLoaded).contact.id : '';

  // ── Handlers ─────────────────────────────────────────────────────────────

  Future<void> _onLoad(LoadChat event, Emitter<ChatState> emit) async {
    emit(const ChatLoading());
    try {
      var messages = await _repo.getMessages(event.contact.id);
      var contact = event.contact;

      // Mark all unread received messages as read on open.
      if (contact.unreadCount > 0) {
        messages = messages
            .map((m) => !m.isSentByMe && m.status != MessageStatus.read
                ? m.copyWith(status: MessageStatus.read)
                : m)
            .toList();
        await _repo.saveMessages(event.contact.id, messages);
        await _repo.updateContactLastMessage(
          contactId: event.contact.id,
          lastMessage: contact.lastMessage,
          time: contact.lastMessageTime,
          unreadCount: 0,
          sentByMe: contact.lastMessageSentByMe,
        );
        contact = contact.copyWith(unreadCount: 0);
      }

      emit(ChatLoaded(contact: contact, messages: messages));
    } catch (e) {
      emit(ChatError('Failed to load chat: $e'));
    }
  }

  Future<void> _onSendText(
      SendTextMessage event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded || event.text.trim().isEmpty) return;
    final loaded = state as ChatLoaded;

    final msg = Message(
      id: _uuid.v4(),
      contactId: _contactId,
      content: event.text.trim(),
      type: MessageType.text,
      isSentByMe: true,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );

    final updated = [...loaded.messages, msg];
    emit(loaded.copyWith(messages: updated));
    await _repo.saveMessages(_contactId, updated);
    await _repo.updateContactLastMessage(
      contactId: _contactId,
      lastMessage: msg.content,
      time: msg.timestamp,
      unreadCount: 0,
      sentByMe: true,
    );

    _scheduleStatusUpdate(msg.id);
    _scheduleReply();
  }

  Future<void> _onSendAttachment(
      SendAttachmentMessage event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final loaded = state as ChatLoaded;

    final preview =
        event.type == MessageType.image ? '📷 Photo' : '📎 ${event.name}';

    final msg = Message(
      id: _uuid.v4(),
      contactId: _contactId,
      type: event.type,
      isSentByMe: true,
      timestamp: DateTime.now(),
      attachmentPath: event.path,
      attachmentName: event.name,
      status: MessageStatus.sent,
    );

    final updated = [...loaded.messages, msg];
    emit(loaded.copyWith(messages: updated));
    await _repo.saveMessages(_contactId, updated);
    await _repo.updateContactLastMessage(
      contactId: _contactId,
      lastMessage: preview,
      time: msg.timestamp,
      unreadCount: 0,
      sentByMe: true,
    );

    _scheduleStatusUpdate(msg.id);
    _scheduleReply();
  }

  Future<void> _onUpdateStatus(
      UpdateMessageStatus event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final loaded = state as ChatLoaded;
    final updated = loaded.messages
        .map((m) => m.id == event.messageId ? m.copyWith(status: event.status) : m)
        .toList();
    emit(loaded.copyWith(messages: updated));
    await _repo.saveMessages(_contactId, updated);
  }

  Future<void> _onSimulateReply(
      SimulateReply event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final loaded = state as ChatLoaded;

    final reply = Message(
      id: _uuid.v4(),
      contactId: _contactId,
      content: _autoReplies[Random().nextInt(_autoReplies.length)],
      type: MessageType.text,
      isSentByMe: false,
      timestamp: DateTime.now(),
      status: MessageStatus.read,
    );

    final updated = [...loaded.messages, reply];
    emit(loaded.copyWith(messages: updated));
    await _repo.saveMessages(_contactId, updated);
    await _repo.updateContactLastMessage(
      contactId: _contactId,
      lastMessage: reply.content,
      time: reply.timestamp,
      unreadCount: 0,
      sentByMe: false,
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  void _scheduleStatusUpdate(String msgId) {
    Future.delayed(const Duration(seconds: 1), () {
      if (!isClosed) {
        add(UpdateMessageStatus(messageId: msgId, status: MessageStatus.delivered));
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        add(UpdateMessageStatus(messageId: msgId, status: MessageStatus.read));
      }
    });
  }

  void _scheduleReply() {
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!isClosed) add(const SimulateReply());
    });
  }
}
