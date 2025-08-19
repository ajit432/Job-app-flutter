part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ConversationsLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<ChatConversationModel> conversations;
  final List<ChatMessageModel> messages;
  final int? selectedConversationId;
  final bool isLoadingMessages;
  final bool isLoadingMoreMessages;
  final bool isSendingMessage;
  final bool hasMoreMessages;
  final ChatTypingIndicatorModel? typingIndicator;
  final String? error;

  const ConversationsLoaded({
    required this.conversations,
    this.messages = const [],
    this.selectedConversationId,
    this.isLoadingMessages = false,
    this.isLoadingMoreMessages = false,
    this.isSendingMessage = false,
    this.hasMoreMessages = true,
    this.typingIndicator,
    this.error,
  });

  @override
  List<Object?> get props => [
        conversations,
        messages,
        selectedConversationId,
        isLoadingMessages,
        isLoadingMoreMessages,
        isSendingMessage,
        hasMoreMessages,
        typingIndicator,
        error,
      ];

  ConversationsLoaded copyWith({
    List<ChatConversationModel>? conversations,
    List<ChatMessageModel>? messages,
    int? selectedConversationId,
    bool? isLoadingMessages,
    bool? isLoadingMoreMessages,
    bool? isSendingMessage,
    bool? hasMoreMessages,
    ChatTypingIndicatorModel? typingIndicator,
    String? error,
  }) {
    return ConversationsLoaded(
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      selectedConversationId: selectedConversationId ?? this.selectedConversationId,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      isLoadingMoreMessages: isLoadingMoreMessages ?? this.isLoadingMoreMessages,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
      typingIndicator: typingIndicator,
      error: error,
    );
  }

  bool get hasConversations => conversations.isNotEmpty;
  bool get hasMessages => messages.isNotEmpty;
  bool get hasSelectedConversation => selectedConversationId != null;
  
  int get totalUnreadCount => conversations
      .map((conv) => conv.unreadCount)
      .fold(0, (sum, count) => sum + count);
  
  ChatConversationModel? get selectedConversation => 
      selectedConversationId != null
          ? conversations.firstWhere(
              (conv) => conv.id == selectedConversationId,
              orElse: () => conversations.first,
            )
          : null;
  
  bool get isTypingIndicatorVisible =>
      typingIndicator != null &&
      typingIndicator!.isRecentlyTyping &&
      typingIndicator!.conversationId == selectedConversationId;
  
  List<ChatMessageModel> get sortedMessages =>
      List.from(messages)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}
