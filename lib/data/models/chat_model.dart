import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../core/constants/app_constants.dart';
import 'user_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatConversationModel extends Equatable {
  final int id;
  final int user1Id;
  final int user2Id;
  final DateTime lastMessageAt;
  final DateTime createdAt;
  final UserModel? otherUser;
  final ChatMessageModel? lastMessage;
  final int unreadCount;

  const ChatConversationModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.lastMessageAt,
    required this.createdAt,
    this.otherUser,
    this.lastMessage,
    required this.unreadCount,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatConversationModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        user1Id,
        user2Id,
        lastMessageAt,
        createdAt,
        otherUser,
        lastMessage,
        unreadCount,
      ];

  ChatConversationModel copyWith({
    int? id,
    int? user1Id,
    int? user2Id,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    UserModel? otherUser,
    ChatMessageModel? lastMessage,
    int? unreadCount,
  }) {
    return ChatConversationModel(
      id: id ?? this.id,
      user1Id: user1Id ?? this.user1Id,
      user2Id: user2Id ?? this.user2Id,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
      otherUser: otherUser ?? this.otherUser,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  static ChatConversationModel mock() {
    return ChatConversationModel(
      id: 1,
      user1Id: 1,
      user2Id: 2,
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 30)),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      otherUser: UserModel.mock().copyWith(
        id: 2,
        email: 'chat@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'Jane Doe',
        ),
      ),
      lastMessage: ChatMessageModel.mock(),
      unreadCount: 2,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(lastMessageAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  bool get hasUnreadMessages => unreadCount > 0;

  String get otherUserName {
    return otherUser?.profile?.fullName ?? otherUser?.email ?? 'Unknown User';
  }

  String? get otherUserProfileImage {
    return otherUser?.profile?.profileImage;
  }
}

@JsonSerializable()
class ChatMessageModel extends Equatable {
  final int id;
  final int conversationId;
  final int senderId;
  final String content;
  final MessageType messageType;
  final String? fileUrl;
  final bool isRead;
  final DateTime createdAt;
  final UserModel? sender;

  const ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
    required this.isRead,
    required this.createdAt,
    this.sender,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        conversationId,
        senderId,
        content,
        messageType,
        fileUrl,
        isRead,
        createdAt,
        sender,
      ];

  ChatMessageModel copyWith({
    int? id,
    int? conversationId,
    int? senderId,
    String? content,
    MessageType? messageType,
    String? fileUrl,
    bool? isRead,
    DateTime? createdAt,
    UserModel? sender,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      fileUrl: fileUrl ?? this.fileUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      sender: sender ?? this.sender,
    );
  }

  static ChatMessageModel mock() {
    return ChatMessageModel(
      id: 1,
      conversationId: 1,
      senderId: 2,
      content: 'Hey! How are you doing?',
      messageType: MessageType.text,
      isRead: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      sender: UserModel.mock().copyWith(
        id: 2,
        email: 'sender@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'Jane Doe',
        ),
      ),
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  String get formattedTime {
    final hour = createdAt.hour;
    final minute = createdAt.minute.toString().padLeft(2, '0');
    final isPM = hour >= 12;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute ${isPM ? 'PM' : 'AM'}';
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == createdAt.day && 
           now.month == createdAt.month && 
           now.year == createdAt.year;
  }

  bool get isImage => messageType == MessageType.image;
  bool get isFile => messageType == MessageType.file;
  bool get isLink => messageType == MessageType.link;
  bool get hasAttachment => fileUrl != null;

  String get displayContent {
    switch (messageType) {
      case MessageType.text:
        return content;
      case MessageType.image:
        return '📷 Photo';
      case MessageType.file:
        return '📄 File';
      case MessageType.link:
        return '🔗 Link';
    }
  }
}

@JsonSerializable()
class ChatTypingIndicatorModel extends Equatable {
  final int conversationId;
  final int userId;
  final bool isTyping;
  final DateTime lastTypingAt;

  const ChatTypingIndicatorModel({
    required this.conversationId,
    required this.userId,
    required this.isTyping,
    required this.lastTypingAt,
  });

  factory ChatTypingIndicatorModel.fromJson(Map<String, dynamic> json) =>
      _$ChatTypingIndicatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatTypingIndicatorModelToJson(this);

  @override
  List<Object?> get props => [
        conversationId,
        userId,
        isTyping,
        lastTypingAt,
      ];

  ChatTypingIndicatorModel copyWith({
    int? conversationId,
    int? userId,
    bool? isTyping,
    DateTime? lastTypingAt,
  }) {
    return ChatTypingIndicatorModel(
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      isTyping: isTyping ?? this.isTyping,
      lastTypingAt: lastTypingAt ?? this.lastTypingAt,
    );
  }

  bool get isRecentlyTyping {
    final now = DateTime.now();
    final difference = now.difference(lastTypingAt);
    return isTyping && difference.inSeconds < 5;
  }
}

enum ChatMessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

extension ChatMessageStatusExtension on ChatMessageStatus {
  String get displayName {
    switch (this) {
      case ChatMessageStatus.sending:
        return 'Sending...';
      case ChatMessageStatus.sent:
        return 'Sent';
      case ChatMessageStatus.delivered:
        return 'Delivered';
      case ChatMessageStatus.read:
        return 'Read';
      case ChatMessageStatus.failed:
        return 'Failed';
    }
  }

  String get value {
    return name;
  }

  static ChatMessageStatus fromString(String value) {
    return ChatMessageStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ChatMessageStatus.sent,
    );
  }
}
