import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/contact_model.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'bloc/chat_bloc.dart';
import 'bloc/chat_event.dart';
import 'bloc/chat_state.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/date_divider.dart';
import 'widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final Contact contact;

  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = ChatBloc(repository: ChatRepository())..add(LoadChat(widget.contact));
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFE7DC), // WhatsApp beige chat wallpaper
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listenWhen: (prev, curr) =>
                    prev is ChatLoaded &&
                    curr is ChatLoaded &&
                    prev.messages.length < curr.messages.length,
                listener: (_, __) => _scrollToBottom(),
                builder: (context, state) {
                  if (state is ChatInitial || state is ChatLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }
                  if (state is ChatError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ChatLoaded) {
                    if (state.messages.isEmpty) return _buildEmptyState();
                    return _buildMessageList(state.messages);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            ChatInputBar(
              onSendText: (text) {
                if (!_bloc.isClosed) _bloc.add(SendTextMessage(text));
              },
              onSendAttachment: (path, name, type) {
                if (!_bloc.isClosed) {
                  _bloc.add(SendAttachmentMessage(path: path, name: name, type: type));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── AppBar ───────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    final contact = widget.contact;
    final colorIndex = contact.name.codeUnits.fold(0, (s, c) => s + c) %
        AppColors.avatarColors.length;

    return AppBar(
      backgroundColor: AppColors.headerDark,
      titleSpacing: 0,
      leadingWidth: 40,
      title: InkWell(
        onTap: () {}, // Could open contact info
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.avatarColors[colorIndex],
                  child: Text(
                    contact.initials,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                if (contact.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.headerDark, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    contact.isOnline ? 'Online' : 'Last seen recently',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.white),
          onPressed: () {},
          tooltip: 'Video call',
        ),
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.white),
          onPressed: () {},
          tooltip: 'Voice call',
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  // ── Message list ─────────────────────────────────────────────────────────

  Widget _buildMessageList(List<Message> messages) {
    // Jump to bottom immediately after first load.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isLastInGroup = _isLastInGroup(index, messages);
        final showDate = _shouldShowDateDivider(index, messages);

        return Column(
          children: [
            if (showDate)
              DateDivider(label: DateFormatter.formatDateDivider(message.timestamp)),
            MessageBubble(message: message, isLastInGroup: isLastInGroup),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No messages yet.\nSay hi to ${widget.contact.name}! 👋',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _isLastInGroup(int index, List<Message> messages) {
    if (index == messages.length - 1) return true;
    final current = messages[index];
    final next = messages[index + 1];
    if (current.isSentByMe != next.isSentByMe) return true;
    return next.timestamp.difference(current.timestamp).inMinutes >= 5;
  }

  bool _shouldShowDateDivider(int index, List<Message> messages) {
    if (index == 0) return true;
    final prev = messages[index - 1].timestamp;
    final curr = messages[index].timestamp;
    return prev.day != curr.day || prev.month != curr.month || prev.year != curr.year;
  }
}
