import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/message_model.dart';

/// Bottom input bar. Handles text input, image picking, and file picking.
/// All results surface via callbacks so the parent can talk to the BLoC.
class ChatInputBar extends StatefulWidget {
  final void Function(String text) onSendText;
  final void Function(String path, String name, MessageType type) onSendAttachment;

  const ChatInputBar({
    super.key,
    required this.onSendText,
    required this.onSendAttachment,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 6,
        bottom: MediaQuery.of(context).padding.bottom + 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text field + emoji + attach
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Emoji icon (decorative)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey.shade500,
                      size: 24,
                    ),
                  ),
                  // Text input
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: 5,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      ),
                    ),
                  ),
                  // Attach icon
                  IconButton(
                    icon: Icon(Icons.attach_file_rounded, color: Colors.grey.shade500),
                    onPressed: () => _showAttachmentSheet(context),
                    tooltip: 'Attach',
                  ),
                  // Camera icon (shortcut to pick from gallery)
                  if (!_hasText)
                    IconButton(
                      icon: Icon(Icons.camera_alt_outlined, color: Colors.grey.shade500),
                      onPressed: () => _pickImage(context),
                      tooltip: 'Photo',
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          // Send / mic button
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: _hasText
                ? _CircleButton(
                    key: const ValueKey('send'),
                    icon: Icons.send_rounded,
                    onTap: _sendText,
                  )
                : _CircleButton(
                    key: const ValueKey('mic'),
                    icon: Icons.mic_rounded,
                    onTap: () {},
                  ),
          ),
        ],
      ),
    );
  }

  void _sendText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSendText(text);
    _controller.clear();
  }

  void _showAttachmentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AttachmentSheet(
        onPickImage: () {
          Navigator.pop(context);
          _pickImage(context);
        },
        onPickFile: () {
          Navigator.pop(context);
          _pickFile(context);
        },
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (!mounted) return; // widget may have been disposed during the await
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;
    final path = file.path;
    if (path == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot read file path on this platform')),
        );
      }
      return;
    }
    widget.onSendAttachment(path, file.name, MessageType.image);
  }

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (!mounted) return; // widget may have been disposed during the await
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;
    final path = file.path;
    if (path == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot read file path on this platform')),
        );
      }
      return;
    }
    widget.onSendAttachment(path, file.name, MessageType.file);
  }
}

// ── Attachment options bottom sheet ──────────────────────────────────────

class _AttachmentSheet extends StatelessWidget {
  final VoidCallback onPickImage;
  final VoidCallback onPickFile;

  const _AttachmentSheet({required this.onPickImage, required this.onPickFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 6),
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AttachOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  color: const Color(0xFF7C4DFF),
                  onTap: onPickImage,
                ),
                _AttachOption(
                  icon: Icons.insert_drive_file_rounded,
                  label: 'Document',
                  color: const Color(0xFF2979FF),
                  onTap: onPickFile,
                ),
                _AttachOption(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  color: const Color(0xFFFF6D00),
                  onTap: onPickImage,
                ),
                _AttachOption(
                  icon: Icons.audiotrack_rounded,
                  label: 'Audio',
                  color: const Color(0xFFE91E63),
                  onTap: onPickFile,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class _AttachOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withAlpha(80), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared circular action button ─────────────────────────────────────────

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
