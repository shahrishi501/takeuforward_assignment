import 'dart:io';
import 'package:flutter/material.dart';

/// Displays a locally-stored image inline inside a chat bubble.
/// Tapping opens a full-screen pinch-to-zoom viewer.
class ImageAttachmentWidget extends StatelessWidget {
  final String filePath;

  const ImageAttachmentWidget({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 150,
          maxWidth: 240,
          minHeight: 80,
          maxHeight: 300,
        ),
        child: file.existsSync()
            ? Image.file(file, fit: BoxFit.cover)
            : _BrokenImagePlaceholder(fileName: filePath.split('/').last),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _FullScreenImageView(filePath: filePath),
      ),
    );
  }
}

class _BrokenImagePlaceholder extends StatelessWidget {
  final String fileName;

  const _BrokenImagePlaceholder({required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 160,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_rounded, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            fileName,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _FullScreenImageView extends StatelessWidget {
  final String filePath;

  const _FullScreenImageView({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          filePath.split('/').last,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.file(File(filePath), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
