part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ConversationsLoadRequested extends ChatEvent {
  const ConversationsLoadRequested();
}

class ConversationSelected extends ChatEvent {
  final int conversationId;

  const ConversationSelected({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class MessagesLoadRequested extends ChatEvent {
  final int conversationId;

  const MessagesLoadRequested({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class MessageSent extends ChatEvent {
  final int conversationId;
  final String content;
  final MessageType messageType;
  final String? fileUrl;

  const MessageSent({
    required this.conversationId,
    required this.content,
    this.messageType = MessageType.text,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [conversationId, content, messageType, fileUrl];
}

class MessageReceived extends ChatEvent {
  final ChatMessageModel message;

  const MessageReceived({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessagesMarkedAsRead extends ChatEvent {
  final int conversationId;

  const MessagesMarkedAsRead({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class TypingIndicatorChanged extends ChatEvent {
  final int conversationId;
  final int userId;
  final bool isTyping;

  const TypingIndicatorChanged({
    required this.conversationId,
    required this.userId,
    required this.isTyping,
  });

  @override
  List<Object?> get props => [conversationId, userId, isTyping];
}

class ConversationCreated extends ChatEvent {
  final int otherUserId;
  final dynamic otherUser; // UserModel - avoiding import here

  const ConversationCreated({
    required this.otherUserId,
    required this.otherUser,
  });

  @override
  List<Object?> get props => [otherUserId, otherUser];
}

class MessageLoadMoreRequested extends ChatEvent {
  final int conversationId;

  const MessageLoadMoreRequested({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}
