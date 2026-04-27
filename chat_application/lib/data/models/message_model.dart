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
