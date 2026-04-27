import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

/// Displays a file attachment (PDF, DOCX, ZIP, …) inside a chat bubble.
/// Shows a colored icon derived from the file extension.
/// Tapping opens the file with the device's native viewer.
class FileAttachmentWidget extends StatelessWidget {
  final String filePath;
  final String fileName;

  const FileAttachmentWidget({
    super.key,
    required this.filePath,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    final ext = _extension(fileName);
    final (icon, color) = _iconForExtension(ext);

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => _openFile(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // File type icon badge
            Container(
              width: 46,
              height: 52,
              decoration: BoxDecoration(
                color: color.withAlpha(28),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withAlpha(60), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color, size: 24),
                  const SizedBox(height: 2),
                  Text(
                    ext.toUpperCase(),
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // File name and info
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111B21),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.touch_app_rounded, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 3),
                      Text(
                        'Tap to open',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.open_in_new_rounded, size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  String _extension(String name) {
    final parts = name.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  (IconData, Color) _iconForExtension(String ext) {
    return switch (ext) {
      'pdf' => (Icons.picture_as_pdf_rounded, const Color(0xFFE53935)),
      'doc' || 'docx' => (Icons.description_rounded, const Color(0xFF1565C0)),
      'xls' || 'xlsx' => (Icons.table_chart_rounded, const Color(0xFF2E7D32)),
      'ppt' || 'pptx' => (Icons.slideshow_rounded, const Color(0xFFF57C00)),
      'zip' || 'rar' || '7z' => (Icons.archive_rounded, const Color(0xFF6D4C41)),
      'mp4' || 'mov' || 'avi' || 'mkv' => (Icons.video_file_rounded, const Color(0xFF7B1FA2)),
      'mp3' || 'wav' || 'aac' || 'm4a' => (Icons.audio_file_rounded, const Color(0xFF00838F)),
      'txt' || 'md' => (Icons.text_snippet_rounded, const Color(0xFF37474F)),
      _ => (Icons.insert_drive_file_rounded, const Color(0xFF546E7A)),
    };
  }

  Future<void> _openFile(BuildContext context) async {
    try {
      final result = await OpenFilex.open(filePath);
      if (result.type != ResultType.done && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cannot open file: ${result.message}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open this file on this device'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
