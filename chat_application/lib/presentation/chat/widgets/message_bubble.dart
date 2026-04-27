import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/message_model.dart';
import 'file_attachment_widget.dart';
import 'image_attachment_widget.dart';

/// Complete chat bubble. Handles text, image, and file message types,
/// and renders the timestamp + read-status footer in each case.
class MessageBubble extends StatelessWidget {
  final Message message;

  /// True when this is the last bubble in a consecutive run from one sender
  /// (draws the small "tail" on the bubble corner).
  final bool isLastInGroup;

  const MessageBubble({
    super.key,
    required this.message,
    this.isLastInGroup = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSentByMe;

    return Padding(
      padding: EdgeInsets.only(
        left: isSent ? 64 : 8,
        right: isSent ? 8 : 64,
        top: 1,
        bottom: isLastInGroup ? 6 : 1,
      ),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: _BubbleShell(
          isSent: isSent,
          isLastInGroup: isLastInGroup,
          child: switch (message.type) {
            MessageType.text => _TextContent(message: message),
            MessageType.image => _ImageContent(message: message),
            MessageType.file => _FileContent(message: message),
          },
        ),
      ),
    );
  }
}

// ── Shell ─────────────────────────────────────────────────────────────────

class _BubbleShell extends StatelessWidget {
  final bool isSent;
  final bool isLastInGroup;
  final Widget child;

  const _BubbleShell({
    required this.isSent,
    required this.isLastInGroup,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(isLastInGroup ? 3 : 16);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSent ? AppColors.sentBubble : AppColors.receivedBubble,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isSent ? const Radius.circular(16) : radius,
          bottomRight: isSent ? radius : const Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x18000000), blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: child,
    );
  }
}

// ── Text content ──────────────────────────────────────────────────────────

class _TextContent extends StatelessWidget {
  final Message message;

  const _TextContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content ?? '',
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 2),
            _Footer(message: message),
          ],
        ),
      ),
    );
  }
}

// ── Image content ─────────────────────────────────────────────────────────

class _ImageContent extends StatelessWidget {
  final Message message;

  const _ImageContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ImageAttachmentWidget(filePath: message.attachmentPath ?? ''),
          // Semi-transparent timestamp overlay on the image
          Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _Footer(message: message, onDarkBackground: true),
            ),
          ),
        ],
      ),
    );
  }
}

// ── File content ──────────────────────────────────────────────────────────

class _FileContent extends StatelessWidget {
  final Message message;

  const _FileContent({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        FileAttachmentWidget(
          filePath: message.attachmentPath ?? '',
          fileName: message.attachmentName ?? 'Unknown file',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
          child: _Footer(message: message),
        ),
      ],
    );
  }
}

// ── Shared footer (timestamp + status icon) ───────────────────────────────

class _Footer extends StatelessWidget {
  final Message message;
  final bool onDarkBackground;

  const _Footer({required this.message, this.onDarkBackground = false});

  @override
  Widget build(BuildContext context) {
    final textColor = onDarkBackground ? Colors.white70 : AppColors.textSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormatter.formatMessageTime(message.timestamp),
          style: TextStyle(fontSize: 11, color: textColor),
        ),
        if (message.isSentByMe) ...[
          const SizedBox(width: 3),
          _StatusIcon(status: message.status, onDark: onDarkBackground),
        ],
      ],
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final MessageStatus status;
  final bool onDark;

  const _StatusIcon({required this.status, this.onDark = false});

  static const _blueRead = Color(0xFF53BDEB);

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      MessageStatus.sent => Icon(
          Icons.done_rounded,
          size: 15,
          color: onDark ? Colors.white60 : AppColors.textSecondary,
        ),
      MessageStatus.delivered => Icon(
          Icons.done_all_rounded,
          size: 15,
          color: onDark ? Colors.white60 : AppColors.textSecondary,
        ),
      MessageStatus.read => Icon(
          Icons.done_all_rounded,
          size: 15,
          color: onDark ? Colors.lightBlueAccent : _blueRead,
        ),
    };
  }
}
