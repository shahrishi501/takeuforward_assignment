import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  static const String _contactsKey = 'contacts_v1';
  static const String _messagesPrefix = 'messages_v1_';

  Future<List<Contact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_contactsKey);
    if (raw == null) {
      final defaults = _seedContacts();
      await saveContacts(defaults);
      return defaults;
    }
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Contact.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _contactsKey, jsonEncode(contacts.map((c) => c.toJson()).toList()));
  }

  Future<List<Message>> getMessages(String contactId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_messagesPrefix$contactId');
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => Message.fromJson(e as Map<String, dynamic>)).toList();
    }
    final seeds = _seedMessages(contactId);
    if (seeds.isNotEmpty) await saveMessages(contactId, seeds);
    return seeds;
  }

  Future<void> saveMessages(String contactId, List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_messagesPrefix$contactId',
      jsonEncode(messages.map((m) => m.toJson()).toList()),
    );
  }

  Future<void> updateContactLastMessage({
    required String contactId,
    required String? lastMessage,
    required DateTime? time,
    required int unreadCount,
    required bool sentByMe,
  }) async {
    final contacts = await getContacts();
    final updated = contacts.map((c) {
      if (c.id != contactId) return c;
      return c.copyWith(
        lastMessage: lastMessage,
        lastMessageTime: time,
        unreadCount: unreadCount,
        lastMessageSentByMe: sentByMe,
      );
    }).toList();

    updated.sort((a, b) {
      final ta = a.lastMessageTime;
      final tb = b.lastMessageTime;
      if (ta == null && tb == null) return 0;
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.compareTo(ta);
    });

    await saveContacts(updated);
  }

  // ── Seed data ────────────────────────────────────────────────────────────

  List<Contact> _seedContacts() {
    final now = DateTime.now();
    return [
      Contact(
        id: 'contact_1',
        name: 'Alice Johnson',
        phone: '+1 234 567 8901',
        lastMessage: 'A chat app actually! 😄',
        lastMessageTime: now.subtract(const Duration(minutes: 3, seconds: 30)),
        unreadCount: 2,
        isOnline: true,
        lastMessageSentByMe: true,
      ),
      Contact(
        id: 'contact_2',
        name: 'Bob Smith',
        phone: '+1 234 567 8902',
        lastMessage: 'See you tomorrow at 10!',
        lastMessageTime: now.subtract(const Duration(hours: 2, minutes: 30)),
        unreadCount: 0,
      ),
      Contact(
        id: 'contact_3',
        name: 'Carol Williams',
        phone: '+1 234 567 8903',
        lastMessage: 'That\'s incredible! Thanks for sharing 🙌',
        lastMessageTime: now.subtract(const Duration(days: 1)),
        unreadCount: 5,
        isOnline: true,
      ),
      Contact(
        id: 'contact_4',
        name: 'Dave Brown',
        phone: '+1 234 567 8904',
        lastMessage: 'Absolutely! Name the time and place 😊',
        lastMessageTime: now.subtract(const Duration(days: 2)),
        unreadCount: 0,
        lastMessageSentByMe: true,
      ),
      Contact(
        id: 'contact_5',
        name: 'Eve Davis',
        phone: '+1 234 567 8905',
        lastMessage: 'Happy to help anytime! 😊',
        lastMessageTime: now.subtract(const Duration(days: 5)),
        unreadCount: 1,
        lastMessageSentByMe: true,
      ),
    ];
  }

  List<Message> _seedMessages(String contactId) {
    final now = DateTime.now();
    return switch (contactId) {
      'contact_1' => [
          _msg(contactId, 'Hey! How are you doing? 😊', false,
              now.subtract(const Duration(minutes: 5))),
          _msg(contactId, 'I\'m doing great! Just been working on a project 💻', true,
              now.subtract(const Duration(minutes: 4))),
          _msg(contactId, 'Ooh, sounds exciting! What kind of project?', false,
              now.subtract(const Duration(minutes: 4))),
          _msg(contactId, 'A chat app actually! 😄', true,
              now.subtract(const Duration(minutes: 3, seconds: 30)),
              status: MessageStatus.read),
        ],
      'contact_2' => [
          _msg(contactId, 'Hey Bob! Still on for tomorrow?', true,
              now.subtract(const Duration(hours: 3)),
              status: MessageStatus.read),
          _msg(contactId, 'Yep, definitely! See you tomorrow at 10!', false,
              now.subtract(const Duration(hours: 2, minutes: 30))),
        ],
      'contact_3' => [
          _msg(contactId, 'Hey Carol! How\'s it going?', true,
              now.subtract(const Duration(days: 1, hours: 2)),
              status: MessageStatus.read),
          _msg(contactId, 'Amazing actually! I just saw the most beautiful sunset 🌅', false,
              now.subtract(const Duration(days: 1, hours: 1))),
          _msg(contactId, 'You should have been there, it was breathtaking!', false,
              now.subtract(const Duration(days: 1, minutes: 59))),
          _msg(contactId, 'That\'s incredible! Thanks for sharing 🙌', false,
              now.subtract(const Duration(days: 1, minutes: 58))),
        ],
      'contact_4' => [
          _msg(contactId, 'Long time no see! Let\'s catch up soon!', false,
              now.subtract(const Duration(days: 2, hours: 1))),
          _msg(contactId, 'Absolutely! Name the time and place 😊', true,
              now.subtract(const Duration(days: 2)),
              status: MessageStatus.read),
        ],
      'contact_5' => [
          _msg(contactId, 'Hey! Thanks for the help yesterday, really saved me!', false,
              now.subtract(const Duration(days: 5, hours: 2))),
          _msg(contactId, 'Happy to help anytime! 😊', true,
              now.subtract(const Duration(days: 5)),
              status: MessageStatus.read),
        ],
      _ => [],
    };
  }

  Message _msg(
    String contactId,
    String content,
    bool isSentByMe,
    DateTime timestamp, {
    MessageStatus status = MessageStatus.delivered,
  }) {
    return Message(
      id: '${contactId}_${timestamp.millisecondsSinceEpoch}',
      contactId: contactId,
      content: content,
      type: MessageType.text,
      isSentByMe: isSentByMe,
      timestamp: timestamp,
      status: status,
    );
  }
}
