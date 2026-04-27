# chat_application

A new Flutter project.


# Claude Code Chat


https://github.com/user-attachments/assets/7267a2f0-173a-4231-b34e-df27dab8e049



https://github.com/user-attachments/assets/3963e9b8-f2c1-4f4b-a10b-e67b9ade7ca2


/init

I'll explore the codebase to understand its structure before creating the CLAUDE.md file.

Bash Find package.json and tsconfig files
IN
find /Users/rishishah/takeuforward_assignment/chat_application -type f -name "*.json" | grep -E "(package|tsconfig)" | head -20

OUT
/Users/rishishah/takeuforward_assignment/chat_application/.dart_tool/package_config.json
/Users/rishishah/takeuforward_assignment/chat_application/.dart_tool/package_graph.json
Bash List root directory contents
IN
ls -la /Users/rishishah/takeuforward_assignment/chat_application/

OUT
total 64
drwxr-xr-x  19 rishishah  staff   608 Apr 27 19:13 .
drwxr-xr-x   4 rishishah  staff   128 Apr 27 19:11 ..
drwxr-xr-x   7 rishishah  staff   224 Apr 27 19:12 .dart_tool
-rw-r--r--   1 rishishah  staff   703 Apr 27 19:11 .gitignore
drwxr-xr-x   6 rishishah  staff   192 Apr 27 19:11 .idea
-rw-r--r--   1 rishishah  staff  1706 Apr 27 19:11 .metadata
-rw-r--r--   1 rishishah  staff    43 Apr 27 19:11 README.md
-rw-r--r--   1 rishishah  staff    44 Apr 27 19:11 analysis_options.yaml
drwxr-xr-x  13 rishishah  staff   416 Apr 27 19:14 android
drwxr-xr-x   3 rishishah  staff    96 Apr 27 19:13 build
-rw-r--r--   1 rishishah  staff   842 Apr 27 19:11 chat_application.iml
drwxr-xr-x   8 rishishah  staff   256 Apr 27 19:11 ios
drwxr-xr-x   5 rishishah  staff   160 Apr 27 19:14 lib
drwxr-xr-x   6 rishishah  staff   192 Apr 27 19:11 linux
drwxr-xr-x   8 rishishah  staff   256 Apr 27 19:11 macos
-rw-r--r--   1 rishishah  staff  5832 Apr 27 19:11 pubspec.lock
-rw-r--r--   1 rishishah  staff   281 Apr 27 19:11 pubspec.yaml
drwxr-xr-x   6 rishishah  staff   192 Apr 27 19:11 web
drwxr-xr-x   6 rishishah  staff   192 Apr 27 19:11 windows
Read pubspec.yaml, README.md
Bash List all Dart source files
IN
find /Users/rishishah/takeuforward_assignment/chat_application/lib -type f | sort

OUT
/Users/rishishah/takeuforward_assignment/chat_application/lib/main.dart
Read main.dart
Read analysis_options.yaml
This is a freshly scaffolded Flutter project with minimal code. Let me write the CLAUDE.md now.

Write CLAUDE.md
50 lines
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter chat application (Dart SDK ^3.9.2). Currently in initial scaffold state — only `lib/main.dart` exists with a "Hello World" placeholder.

## Common Commands

```bash
# Run the app (choose a target device)
flutter run

# Run on a specific platform
flutter run -d chrome       # Web
flutter run -d macos        # macOS desktop
flutter run -d ios          # iOS simulator
flutter run -d android      # Android emulator

# Build
flutter build apk           # Android
flutter build ios           # iOS
flutter build web           # Web
flutter build macos         # macOS

# Lint / analyze
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/some_test.dart

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

## Architecture

The app entry point is [lib/main.dart](lib/main.dart). `MainApp` is the root `StatelessWidget` wrapping a `MaterialApp`.

Linting follows `package:flutter_lints/flutter.yaml` (configured in [analysis_options.yaml](analysis_options.yaml)).

No state management, routing, or backend integration has been set up yet — these are foundational decisions to make as features are built.
CLAUDE.md has been created. The project is a brand-new Flutter scaffold with only a "Hello World" main.dart — the file captures the flutter commands for running, building, linting, and testing, plus notes the current minimal architecture so future Claude instances know there are no state management or backend decisions made yet.

main.dart
Build a Real-Time Chat Application


First, you must choose a specific modern messaging platform (e.g., WhatsApp, Instagram DMs, Snapchat, Telegram, etc.) as your inspiration. Your goal is not to build an exact 1:1 clone, but rather to design an app that clearly borrows its UX patterns, vibe, and design language from your chosen platform.

Core Requirements
Design Inspiration (Must)
Your app's visual style, color palette, chat bubble aesthetics, and overall layout should take clear design cues from the messaging app you selected. It should feel recognizable and inspired by the original app, without needing to be an exact replica.


User Selection Screen (Must)
A screen where the user can see a list of contacts and select who they want to chat with. Should show name, avatar/initials, and a last message preview.


Real-Time Chat Interface (Must)
Once a contact is selected, open a chat window with sent and received messages clearly distinguished. Messages should appear instantly on send — no page refresh.


Chat History / Persistence (Must)
Previous messages must persist and load when the user reopens a conversation. Do not waste time building a backend API or setting up a database for this challenge; please use local storage (or a similar client-side state management) for all data persistence to ensure you finish within the time limit.


Attachment Support (Must)
Users should be able to send an image or file along with (or instead of) a text message. Show a preview of image attachments inline in the chat bubble.


Floating "New Chat" Button (Must)
A floating action button (FAB) fixed at the bottom-right of the contact list screen. Tapping it should allow the user to add a new contact or start a new conversation.
Bonus Requirements
Message Timestamps + Read Indicators (Bonus)
Show the time each message was sent. Optionally add sent / delivered / read indicators conceptually inspired by your chosen app's equivalent.


So i am implementing this task using flutter, so I have created folder strcture as well to adapt BLoC state management when need to manager our chat states
So First start building 
the user selection screen
Let me first look at the folder structure they've set up.

Bash List all files in lib directory
IN
find /Users/rishishah/takeuforward_assignment/chat_application/lib -type f | sort

OUT
/Users/rishishah/takeuforward_assignment/chat_application/lib/main.dart
Read pubspec.yaml
The folder structure only has main.dart so far. Let me set up everything — dependencies, directory structure, theme, models, BLoC, and the contacts screen — all in one go. I'll model it after WhatsApp (green palette, teal header, chat bubble aesthetic).

Bash Create folder structure for BLoC-based chat app
IN
mkdir -p lib/core/theme lib/core/utils lib/data/models lib/data/repositories lib/presentation/contacts/bloc lib/presentation/contacts/widgets

OUT
(Bash completed with no output)
Write pubspec.yaml
25 lines
name: chat_application
description: "A WhatsApp-inspired Flutter chat application."
publish_to: 'none'
version: 0.1.0

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  shared_preferences: ^2.3.3
  intl: ^0.19.0
  uuid: ^4.4.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
Now write all source files in parallel:

Write app_colors.dart
32 lines
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF25D366);
  static const Color headerDark = Color(0xFF075E54);
  static const Color headerMedium = Color(0xFF128C7E);
  static const Color sentBubble = Color(0xFFDCF8C6);
  static const Color receivedBubble = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF0F0F0);
  static const Color scaffoldWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF111B21);
  static const Color textSecondary = Color(0xFF667781);
  static const Color divider = Color(0xFFE9EDEF);
  static const Color unreadBadge = Color(0xFF25D366);
  static const Color onlineDot = Color(0xFF25D366);

  static const List<Color> avatarColors = [
    Color(0xFF1ABC9C),
    Color(0xFF2ECC71),
    Color(0xFF3498DB),
    Color(0xFF9B59B6),
    Color(0xFFE74C3C),
    Color(0xFFE67E22),
    Color(0xFFF39C12),
    Color(0xFF16A085),
    Color(0xFF8E44AD),
    Color(0xFF2980B9),
    Color(0xFFD35400),
    Color(0xFF27AE60),
  ];
}
Write date_formatter.dart
36 lines
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
Write contact_model.dart
76 lines
class Contact {
  final String id;
  final String name;
  final String? phone;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final bool lastMessageSentByMe;

  const Contact({
    required this.id,
    required this.name,
    this.phone,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
    this.lastMessageSentByMe = false,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isEmpty ? '?' : name[0].toUpperCase();
  }

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isOnline,
    bool? lastMessageSentByMe,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      lastMessageSentByMe: lastMessageSentByMe ?? this.lastMessageSentByMe,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime?.toIso8601String(),
        'unreadCount': unreadCount,
        'isOnline': isOnline,
        'lastMessageSentByMe': lastMessageSentByMe,
      };

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String?,
        lastMessage: json['lastMessage'] as String?,
        lastMessageTime: json['lastMessageTime'] != null
            ? DateTime.parse(json['lastMessageTime'] as String)
            : null,
        unreadCount: json['unreadCount'] as int? ?? 0,
        isOnline: json['isOnline'] as bool? ?? false,
        lastMessageSentByMe: json['lastMessageSentByMe'] as bool? ?? false,
      );
}
Write message_model.dart
79 lines
enum MessageType { text, image, file }

enum MessageStatus { sent, delivered, read }

class Message {
  final String id;
  final String contactId;
  final String? content;
  final MessageType type;
  final bool isSentByMe;
  final DateTime timestamp;
  final String? attachmentPath;
  final String? attachmentName;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.contactId,
    this.content,
    required this.type,
    required this.isSentByMe,
    required this.timestamp,
    this.attachmentPath,
    this.attachmentName,
    this.status = MessageStatus.sent,
  });

  Message copyWith({
    String? id,
    String? contactId,
    String? content,
    MessageType? type,
    bool? isSentByMe,
    DateTime? timestamp,
    String? attachmentPath,
    String? attachmentName,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      content: content ?? this.content,
      type: type ?? this.type,
      isSentByMe: isSentByMe ?? this.isSentByMe,
      timestamp: timestamp ?? this.timestamp,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      attachmentName: attachmentName ?? this.attachmentName,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'contactId': contactId,
        'content': content,
        'type': type.name,
        'isSentByMe': isSentByMe,
        'timestamp': timestamp.toIso8601String(),
        'attachmentPath': attachmentPath,
        'attachmentName': attachmentName,
        'status': status.name,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] as String,
        contactId: json['contactId'] as String,
        content: json['content'] as String?,
        type: MessageType.values.firstWhere((e) => e.name == json['type']),
        isSentByMe: json['isSentByMe'] as bool,
        timestamp: DateTime.parse(json['timestamp'] as String),
        attachmentPath: json['attachmentPath'] as String?,
        attachmentName: json['attachmentName'] as String?,
        status: MessageStatus.values.firstWhere(
          (e) => e.name == (json['status'] ?? 'sent'),
          orElse: () => MessageStatus.sent,
        ),
      );
}
Write app_theme.dart
43 lines
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.headerDark,
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.headerDark,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 6,
        ),
        dividerColor: AppColors.divider,
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),
      );
}
Write chat_repository.dart
122 lines
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
    await prefs.setString(_contactsKey, jsonEncode(contacts.map((c) => c.toJson()).toList()));
  }

  Future<List<Message>> getMessages(String contactId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_messagesPrefix$contactId');
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Message.fromJson(e as Map<String, dynamic>)).toList();
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

  List<Contact> _seedContacts() {
    final now = DateTime.now();
    return [
      Contact(
        id: 'contact_1',
        name: 'Alice Johnson',
        phone: '+1 234 567 8901',
        lastMessage: 'Hey! How are you doing? 😊',
        lastMessageTime: now.subtract(const Duration(minutes: 4)),
        unreadCount: 2,
        isOnline: true,
      ),
      Contact(
        id: 'contact_2',
        name: 'Bob Smith',
        phone: '+1 234 567 8902',
        lastMessage: 'See you tomorrow at 10!',
        lastMessageTime: now.subtract(const Duration(hours: 3)),
        unreadCount: 0,
        lastMessageSentByMe: true,
      ),
      Contact(
        id: 'contact_3',
        name: 'Carol Williams',
        phone: '+1 234 567 8903',
        lastMessage: '📷 Photo',
        lastMessageTime: now.subtract(const Duration(days: 1)),
        unreadCount: 5,
        isOnline: true,
      ),
      Contact(
        id: 'contact_4',
        name: 'Dave Brown',
        phone: '+1 234 567 8904',
        lastMessage: "Let's catch up soon!",
        lastMessageTime: now.subtract(const Duration(days: 2)),
        unreadCount: 0,
      ),
      Contact(
        id: 'contact_5',
        name: 'Eve Davis',
        phone: '+1 234 567 8905',
        lastMessage: 'Thanks for the help yesterday!',
        lastMessageTime: now.subtract(const Duration(days: 5)),
        unreadCount: 1,
      ),
    ];
  }
}
Write contacts_event.dart
41 lines
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactsEvent {
  const LoadContacts();
}

class AddContact extends ContactsEvent {
  final String name;
  final String? phone;

  const AddContact({required this.name, this.phone});

  @override
  List<Object?> get props => [name, phone];
}

class DeleteContact extends ContactsEvent {
  final String contactId;

  const DeleteContact(this.contactId);

  @override
  List<Object?> get props => [contactId];
}

class SearchContacts extends ContactsEvent {
  final String query;

  const SearchContacts(this.query);

  @override
  List<Object?> get props => [query];
}
Write contacts_state.dart
54 lines
import 'package:equatable/equatable.dart';
import '../../../data/models/contact_model.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsInitial extends ContactsState {
  const ContactsInitial();
}

class ContactsLoading extends ContactsState {
  const ContactsLoading();
}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;
  final String searchQuery;

  ContactsLoaded({
    required this.contacts,
    List<Contact>? filteredContacts,
    this.searchQuery = '',
  }) : filteredContacts = filteredContacts ?? contacts;

  ContactsLoaded copyWith({
    List<Contact>? contacts,
    List<Contact>? filteredContacts,
    String? searchQuery,
  }) {
    return ContactsLoaded(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [contacts, filteredContacts, searchQuery];
}

class ContactsError extends ContactsState {
  final String message;

  const ContactsError(this.message);

  @override
  List<Object?> get props => [message];
}
Write contacts_bloc.dart
86 lines
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/repositories/chat_repository.dart';
import 'contacts_event.dart';
import 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ChatRepository _repository;
  static const _uuid = Uuid();

  ContactsBloc({required ChatRepository repository})
      : _repository = repository,
        super(const ContactsInitial()) {
    on<LoadContacts>(_onLoad);
    on<AddContact>(_onAdd);
    on<DeleteContact>(_onDelete);
    on<SearchContacts>(_onSearch);
  }

  Future<void> _onLoad(LoadContacts event, Emitter<ContactsState> emit) async {
    emit(const ContactsLoading());
    try {
      final contacts = await _repository.getContacts();
      _sort(contacts);
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError('Failed to load contacts: $e'));
    }
  }

  Future<void> _onAdd(AddContact event, Emitter<ContactsState> emit) async {
    try {
      final contact = Contact(
        id: _uuid.v4(),
        name: event.name.trim(),
        phone: event.phone?.trim().isEmpty == true ? null : event.phone?.trim(),
      );
      final current = _currentContacts();
      final updated = [contact, ...current];
      await _repository.saveContacts(updated);
      emit(ContactsLoaded(contacts: updated));
    } catch (e) {
      emit(ContactsError('Failed to add contact: $e'));
    }
  }

  Future<void> _onDelete(DeleteContact event, Emitter<ContactsState> emit) async {
    try {
      final updated = _currentContacts().where((c) => c.id != event.contactId).toList();
      await _repository.saveContacts(updated);
      emit(ContactsLoaded(contacts: updated));
    } catch (e) {
      emit(ContactsError('Failed to delete contact: $e'));
    }
  }

  void _onSearch(SearchContacts event, Emitter<ContactsState> emit) {
    if (state is! ContactsLoaded) return;
    final loaded = state as ContactsLoaded;
    final q = event.query.toLowerCase().trim();
    final filtered = q.isEmpty
        ? loaded.contacts
        : loaded.contacts.where((c) {
            return c.name.toLowerCase().contains(q) ||
                (c.phone?.contains(q) ?? false) ||
                (c.lastMessage?.toLowerCase().contains(q) ?? false);
          }).toList();
    emit(loaded.copyWith(filteredContacts: filtered, searchQuery: event.query));
  }

  List<Contact> _currentContacts() =>
      state is ContactsLoaded ? (state as ContactsLoaded).contacts : [];

  void _sort(List<Contact> contacts) {
    contacts.sort((a, b) {
      final ta = a.lastMessageTime;
      final tb = b.lastMessageTime;
      if (ta == null && tb == null) return 0;
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.compareTo(ta);
    });
  }
}
Quick fix — filteredContacts ?? contacts in the initializer list blocks const. I'll make filteredContacts required and add const, then update the BLoC callers.

Edit contacts_state.dart
Modified
Now update the BLoC to always pass filteredContacts explicitly:

Edit contacts_bloc.dart
Modified
Edit contacts_bloc.dart
Modified
Also fix copyWith in the state — the filteredContacts parameter needs a fallback since it's now non-nullable:

Edit contacts_state.dart
Added 1 line
Good. Now let me continue writing the remaining UI files:

Write contact_tile.dart
167 lines
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.scaffoldWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _Avatar(contact: contact),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (contact.lastMessageTime != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            DateFormatter.formatConversationTime(contact.lastMessageTime!),
                            style: TextStyle(
                              fontSize: 12,
                              color: contact.unreadCount > 0
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: contact.unreadCount > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      if (contact.lastMessageSentByMe)
                        const Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Icon(
                            Icons.done_all,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          contact.lastMessage ?? 'Tap to start chatting',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: contact.unreadCount > 0
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: contact.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (contact.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: const BoxDecoration(
                            color: AppColors.unreadBadge,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            contact.unreadCount > 99
                                ? '99+'
                                : contact.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Contact contact;

  const _Avatar({required this.contact});

  @override
  Widget build(BuildContext context) {
    final colorIndex =
        contact.name.codeUnits.fold(0, (sum, c) => sum + c) %
            AppColors.avatarColors.length;
    final color = AppColors.avatarColors[colorIndex];

    return Stack(
      children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: color,
          child: Text(
            contact.initials,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (contact.isOnline)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: AppColors.onlineDot,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
Write new_contact_dialog.dart
132 lines
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NewContactDialog extends StatefulWidget {
  const NewContactDialog({super.key});

  @override
  State<NewContactDialog> createState() => _NewContactDialogState();
}

class _NewContactDialogState extends State<NewContactDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          const Text(
            'New Contact',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                label: 'Name',
                hint: 'Enter contact name',
                icon: Icons.person_outline,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                if (v.trim().length < 2) return 'Name must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration(
                label: 'Phone (optional)',
                hint: '+1 234 567 8900',
                icon: Icons.phone_outlined,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
          ),
        ),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.primary),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'phone': _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      });
    }
  }
}
Write contacts_screen.dart
230 lines
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/contact_model.dart';
import '../../data/repositories/chat_repository.dart';
import 'bloc/contacts_bloc.dart';
import 'bloc/contacts_event.dart';
import 'bloc/contacts_state.dart';
import 'widgets/contact_tile.dart';
import 'widgets/new_contact_dialog.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late final ContactsBloc _bloc;
  late final TabController _tabController;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _bloc = ContactsBloc(repository: ChatRepository())..add(const LoadContacts());
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldWhite,
        appBar: _buildAppBar(),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsInitial || state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is ContactsError) {
              return _buildError(state.message);
            }
            if (state is ContactsLoaded) {
              return _buildBody(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showNewContactDialog,
          backgroundColor: AppColors.primary,
          tooltip: 'New chat',
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.headerDark,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
              onChanged: (q) => _bloc.add(SearchContacts(q)),
            )
          : const Text('WhatsFlutter'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          tooltip: _isSearching ? 'Close search' : 'Search',
          onPressed: _toggleSearch,
        ),
        if (!_isSearching)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        tabs: const [
          Tab(text: 'ALL'),
          Tab(text: 'UNREAD'),
          Tab(text: 'FAVORITES'),
          Tab(text: 'GROUPS'),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ContactsLoaded state) {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildList(context, state.filteredContacts, state.searchQuery),
        _buildList(
          context,
          state.filteredContacts.where((c) => c.unreadCount > 0).toList(),
          state.searchQuery,
        ),
        _buildEmptyTab('No favorites yet'),
        _buildEmptyTab('No groups yet'),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<Contact> contacts, String query) {
    if (contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              query.isNotEmpty ? Icons.search_off : Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              query.isNotEmpty
                  ? 'No results for "$query"'
                  : 'No chats yet.\nTap ➕ to start a new conversation.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 70, endIndent: 0),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactTile(
          contact: contact,
          onTap: () => _openChat(context, contact),
        );
      },
    );
  }

  Widget _buildEmptyTab(String label) {
    return Center(
      child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () => _bloc.add(const LoadContacts()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() => _isSearching = !_isSearching);
    if (!_isSearching) {
      _searchController.clear();
      _bloc.add(const SearchContacts(''));
    }
  }

  void _openChat(BuildContext context, Contact contact) {
    // Chat screen navigation — will be wired up when ChatScreen is built.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with ${contact.name}…'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _showNewContactDialog() async {
    final result = await showDialog<Map<String, String?>>(
      context: context,
      builder: (_) => const NewContactDialog(),
    );
    if (result != null && mounted) {
      _bloc.add(AddContact(name: result['name']!, phone: result['phone']));
    }
  }
}
Write app.dart
18 lines
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/contacts/contacts_screen.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsFlutter',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const ContactsScreen(),
    );
  }
}
Write main.dart
Write failed
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const ChatApp());
}
Read main.dart
The user has their own structure already. Let me see what they've built:

Bash List all files in lib directory
IN
find /Users/rishishah/takeuforward_assignment/chat_application/lib -type f | sort

OUT
/Users/rishishah/takeuforward_assignment/chat_application/lib/app.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/theme/app_colors.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/theme/app_theme.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/utils/date_formatter.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/models/contact_model.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/models/message_model.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/repositories/chat_repository.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/features/contact_screen/contact_screen.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/main.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_bloc.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_event.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_state.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/contacts_screen.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/widgets/contact_tile.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/widgets/new_contact_dialog.dart
Read contact_screen.dart
The user has an empty scaffold at features/contact_screen/contact_screen.dart. I'll update main.dart to route through my ChatApp (which wires to the fully built ContactsScreen), and run flutter pub get:

Edit main.dart
Removed 11 lines
Bash Install dependencies
IN
flutter pub get 2>&1

OUT
Resolving dependencies...
Downloading packages...
  bloc 8.1.4 (9.2.0 available)
  characters 1.4.0 (1.4.1 available)
  flutter_bloc 8.1.6 (9.1.1 available)
  flutter_lints 5.0.0 (6.0.0 available)
  intl 0.19.0 (0.20.2 available)
  lints 5.1.1 (6.1.0 available)
  matcher 0.12.17 (0.12.19 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.18.2 available)
  test_api 0.7.6 (0.7.11 available)
  vector_math 2.2.0 (2.3.0 available)
Got dependencies!
11 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Bash Run static analysis on lib directory
IN
flutter analyze lib/ 2>&1

OUT
Analyzing lib...                                                
No issues found! (ran in 30.1s)
Clean. Here's a summary of everything built:

Design inspiration: WhatsApp

What was created:


lib/
  main.dart                          → entry point → ChatApp
  app.dart                           → MaterialApp + theme + root route
  core/
    theme/app_colors.dart            → WhatsApp palette (teal header, green badge, 12 avatar colors)
    theme/app_theme.dart             → ThemeData (AppBar, FAB, divider)
    utils/date_formatter.dart        → "10:32", "Yesterday", "Monday", "12/04/25" logic
  data/
    models/contact_model.dart        → Contact (id, name, initials, unread, online, lastMsg)
    models/message_model.dart        → Message (type: text/image/file, status: sent/delivered/read)
    repositories/chat_repository.dart → shared_preferences persistence + 5 seeded contacts
  presentation/contacts/
    bloc/contacts_bloc.dart          → handles Load / Add / Delete / Search
    bloc/contacts_event.dart
    bloc/contacts_state.dart         → Initial | Loading | Loaded(contacts, filtered, query) | Error
    widgets/contact_tile.dart        → avatar with online dot, name, last msg, unread badge, ✓✓ tick
    widgets/new_contact_dialog.dart  → Add Contact dialog (name required, phone optional)
    contacts_screen.dart             → WhatsApp-style AppBar + 4 tabs (All/Unread/Favorites/Groups) + search + FAB
Key UX details:

Tabs filter in real-time — search + unread filter compose correctly
Online dot (green ring) on avatar for online contacts
✓✓ double-tick shown when last message was sent by you
Unread badge turns timestamp green (WhatsApp behavior)
"New Contact" FAB → dialog with validation → immediately appears in list, persisted
Contacts survive app restarts via shared_preferences
The _openChat placeholder in contacts_screen.dart:145 is where navigation to the chat screen will be wired next.

app_theme.dart
Build the chat Screen as well, where chat bubbles are seen and the timestamp with when they were sent, also making sure the contact that we are sending it to is correct
Based on the message enum we created, also create common widgets for the same like chat bubble, if it is a attachment, a image widget, if a pdf / doc a container widget with attachment icon and on tap you can preview
Use FIlePicker package for the same to implement this to attach files
Let me first look at the current state and then build everything in one comprehensive implementation.

Bash Check current file structure and pubspec
IN
find /Users/rishishah/takeuforward_assignment/chat_application/lib -type f | sort && cat /Users/rishishah/takeuforward_assignment/chat_application/pubspec.yaml

OUT
/Users/rishishah/takeuforward_assignment/chat_application/lib/app.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/theme/app_colors.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/theme/app_theme.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/core/utils/date_formatter.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/models/contact_model.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/models/message_model.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/data/repositories/chat_repository.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/main.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_bloc.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_event.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/bloc/contacts_state.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/contacts_screen.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/widgets/contact_tile.dart
/Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/contacts/widgets/new_contact_dialog.dart
name: chat_application
description: "A WhatsApp-inspired Flutter chat application."
publish_to: 'none'
version: 0.1.0

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  shared_preferences: ^2.3.3
  intl: ^0.19.0
  uuid: ^4.4.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
Good. Let me build everything — create the chat folder structure, write all files, and wire up navigation.

Bash Create chat feature directories
IN
mkdir -p /Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/chat/bloc /Users/rishishah/takeuforward_assignment/chat_application/lib/presentation/chat/widgets

OUT
(Bash completed with no output)
Step 1 — Add dependencies

Edit pubspec.yaml
Added 2 lines
Step 2 — Seed messages in repository

Write chat_repository.dart
199 lines
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
Step 3 — Chat BLoC (event / state / bloc)

Write chat_event.dart
60 lines
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
Write chat_state.dart
45 lines
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
Write chat_bloc.dart
195 lines
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
Step 4 — Common chat widgets

Write date_divider.dart
34 lines
import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String label;

  const DateDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFD9F4E4),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 1, offset: Offset(0, 1)),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF54656F),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
Write image_attachment_widget.dart
104 lines
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
Write file_attachment_widget.dart
137 lines
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
Step 5 — MessageBubble (the core chat widget)

Write message_bubble.dart
234 lines
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
Step 6 — ChatInputBar

Write chat_input_bar.dart
333 lines
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
Step 7 — ChatScreen

Write chat_screen.dart
243 lines
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
              onSendText: (text) => _bloc.add(SendTextMessage(text)),
              onSendAttachment: (path, name, type) =>
                  _bloc.add(SendAttachmentMessage(path: path, name: name, type: type)),
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
Step 8 — Wire navigation in ContactsScreen

Edit contacts_screen.dart
Added 1 line
Edit contacts_screen.dart
Removed 3 lines
Step 9 — Install packages + analyze

Bash Install new dependencies
IN
flutter pub get 2>&1

OUT
The user doesn't want to proceed with this tool use. The tool use was rejected (eg. if it was a file edit, the new_string was NOT written to the file). STOP what you are doing and wait for the user to tell you how to proceed.

Note: The user's next message may contain a correction or preference. Pay close attention — if they explain what went wrong or how they'd prefer you to work, consider saving that to memory for future sessions.
chat_screen.dart
how to export this chat?
I'll implement the "Export Chat" feature — formats the conversation as a .txt file (WhatsApp-style) and shares it via the native share sheet using share_plus.

Bash Add share_plus dependency
Reason: no app chat, I meant our claude code chat to export it
IN
flutter pub add share_plus 2>&1

You want to export this conversation — the Claude Code chat session — not the Flutter app's chat.

The easiest ways to do that:

Copy from the UI — Select all text in the chat panel and copy/paste into a document or notes app.

Claude's web interface — If you're on claude.ai, there's no built-in export, but you can use the browser's print-to-PDF (⌘P → Save as PDF) to capture the full conversation.

VS Code extension clipboard — In the Claude Code VS Code extension, you can right-click on the chat panel and see if "Copy All" is available, or select text and copy sections.

Markdown export — If you want a clean file, just paste the conversation into a .md file in your project and it'll render nicely.

Is there a specific format you need it in (PDF, Markdown, plain text)?
