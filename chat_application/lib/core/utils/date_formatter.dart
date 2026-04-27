import 'package:intl/intl.dart';

class DateFormatter {
  static String formatConversationTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDay == today) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (messageDay == yesterday) {
      return 'Yesterday';
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('dd/MM/yy').format(dateTime);
    }
  }

  static String formatMessageTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatDateDivider(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDay == today) return 'Today';
    if (messageDay == yesterday) return 'Yesterday';
    return DateFormat('MMMM d, y').format(dateTime);
  }
}
