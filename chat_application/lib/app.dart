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
