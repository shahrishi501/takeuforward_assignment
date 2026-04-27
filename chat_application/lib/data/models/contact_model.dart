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
