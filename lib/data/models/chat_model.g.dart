// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConversationModel _$ChatConversationModelFromJson(
        Map<String, dynamic> json) =>
    ChatConversationModel(
      id: (json['id'] as num).toInt(),
      user1Id: (json['user1Id'] as num).toInt(),
      user2Id: (json['user2Id'] as num).toInt(),
      lastMessageAt: DateTime.parse(json['lastMessageAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      otherUser: json['otherUser'] == null
          ? null
          : UserModel.fromJson(json['otherUser'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChatConversationModelToJson(
        ChatConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1Id': instance.user1Id,
      'user2Id': instance.user2Id,
      'lastMessageAt': instance.lastMessageAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'otherUser': instance.otherUser,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
    };

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversationId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      content: json['content'] as String,
      messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
      fileUrl: json['fileUrl'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sender: json['sender'] == null
          ? null
          : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'fileUrl': instance.fileUrl,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'sender': instance.sender,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.link: 'link',
};

ChatTypingIndicatorModel _$ChatTypingIndicatorModelFromJson(
        Map<String, dynamic> json) =>
    ChatTypingIndicatorModel(
      conversationId: (json['conversationId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      isTyping: json['isTyping'] as bool,
      lastTypingAt: DateTime.parse(json['lastTypingAt'] as String),
    );

Map<String, dynamic> _$ChatTypingIndicatorModelToJson(
        ChatTypingIndicatorModel instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'userId': instance.userId,
      'isTyping': instance.isTyping,
      'lastTypingAt': instance.lastTypingAt.toIso8601String(),
    };
