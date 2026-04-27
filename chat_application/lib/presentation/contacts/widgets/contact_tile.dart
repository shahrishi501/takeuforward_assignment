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
