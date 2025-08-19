import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/chat_model.dart';
import '../../../core/constants/app_constants.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ConversationsLoadRequested>(_onConversationsLoadRequested);
    on<ConversationSelected>(_onConversationSelected);
    on<MessagesLoadRequested>(_onMessagesLoadRequested);
    on<MessageSent>(_onMessageSent);
    on<MessageReceived>(_onMessageReceived);
    on<MessagesMarkedAsRead>(_onMessagesMarkedAsRead);
    on<TypingIndicatorChanged>(_onTypingIndicatorChanged);
    on<ConversationCreated>(_onConversationCreated);
    on<MessageLoadMoreRequested>(_onMessageLoadMoreRequested);
  }

  Future<void> _onConversationsLoadRequested(
    ConversationsLoadRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ConversationsLoading());
    
    try {
      // TODO: Load conversations from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final conversations = [
        ChatConversationModel.mock(),
        ChatConversationModel.mock().copyWith(
          id: 2,
          user2Id: 3,
          lastMessageAt: DateTime.now().subtract(const Duration(hours: 2)),
          unreadCount: 0,
          otherUser: ChatConversationModel.mock().otherUser?.copyWith(
            id: 3,
            email: 'another@example.com',
            profile: ChatConversationModel.mock().otherUser?.profile?.copyWith(
              id: 3,
              userId: 3,
              fullName: 'Bob Wilson',
            ),
          ),
          lastMessage: ChatMessageModel.mock().copyWith(
            id: 2,
            content: 'Thanks for the info!',
            isRead: true,
          ),
        ),
      ];
      
      emit(ConversationsLoaded(conversations: conversations));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> _onConversationSelected(
    ConversationSelected event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    emit(currentState.copyWith(selectedConversationId: event.conversationId));
    
    // Load messages for the selected conversation
    add(MessagesLoadRequested(conversationId: event.conversationId));
  }

  Future<void> _onMessagesLoadRequested(
    MessagesLoadRequested event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    emit(currentState.copyWith(isLoadingMessages: true));
    
    try {
      // TODO: Load messages from repository
      await Future.delayed(const Duration(milliseconds: 800)); // Mock delay
      
      final messages = [
        ChatMessageModel.mock(),
        ChatMessageModel.mock().copyWith(
          id: 2,
          content: 'How are you doing?',
          senderId: 1, // Current user
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          isRead: true,
        ),
        ChatMessageModel.mock().copyWith(
          id: 3,
          content: 'I\'m doing great! Thanks for asking.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
          isRead: true,
        ),
        ChatMessageModel.mock().copyWith(
          id: 4,
          content: 'That\'s wonderful to hear!',
          senderId: 1, // Current user
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          isRead: true,
        ),
      ];
      
      emit(currentState.copyWith(
        messages: messages,
        isLoadingMessages: false,
        selectedConversationId: event.conversationId,
        hasMoreMessages: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isLoadingMessages: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    
    // Create optimistic message
    final optimisticMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch,
      conversationId: event.conversationId,
      senderId: 1, // Current user ID - should come from auth
      content: event.content,
      messageType: event.messageType,
      fileUrl: event.fileUrl,
      isRead: false,
      createdAt: DateTime.now(),
    );
    
    // Add optimistic message to state
    final updatedMessages = [optimisticMessage, ...currentState.messages];
    
    emit(currentState.copyWith(
      messages: updatedMessages,
      isSendingMessage: true,
    ));
    
    try {
      // TODO: Send message via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      // Update message with server response
      final sentMessage = optimisticMessage.copyWith(
        id: 9999, // Would come from server
        isRead: false,
      );
      
      final finalMessages = updatedMessages
          .map((msg) => msg.id == optimisticMessage.id ? sentMessage : msg)
          .toList();
      
      // Update conversation's last message
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(
            lastMessage: sentMessage,
            lastMessageAt: sentMessage.createdAt,
          );
        }
        return conv;
      }).toList();
      
      emit(currentState.copyWith(
        messages: finalMessages,
        conversations: updatedConversations,
        isSendingMessage: false,
      ));
    } catch (e) {
      // Remove optimistic message on failure
      final failedMessages = currentState.messages
          .where((msg) => msg.id != optimisticMessage.id)
          .toList();
      
      emit(currentState.copyWith(
        messages: failedMessages,
        isSendingMessage: false,
        error: 'Failed to send message: ${e.toString()}',
      ));
    }
  }

  Future<void> _onMessageReceived(
    MessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    
    // Add new message to the list
    final updatedMessages = [event.message, ...currentState.messages];
    
    // Update conversation with new message
    final updatedConversations = currentState.conversations.map((conv) {
      if (conv.id == event.message.conversationId) {
        final newUnreadCount = conv.id == currentState.selectedConversationId
            ? conv.unreadCount // Don't increment if conversation is open
            : conv.unreadCount + 1;
        
        return conv.copyWith(
          lastMessage: event.message,
          lastMessageAt: event.message.createdAt,
          unreadCount: newUnreadCount,
        );
      }
      return conv;
    }).toList();
    
    emit(currentState.copyWith(
      messages: updatedMessages,
      conversations: updatedConversations,
    ));
  }

  Future<void> _onMessagesMarkedAsRead(
    MessagesMarkedAsRead event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    
    try {
      // TODO: Mark messages as read via repository
      
      // Update messages
      final updatedMessages = currentState.messages.map((msg) {
        if (msg.conversationId == event.conversationId && !msg.isRead) {
          return msg.copyWith(isRead: true);
        }
        return msg;
      }).toList();
      
      // Update conversation unread count
      final updatedConversations = currentState.conversations.map((conv) {
        if (conv.id == event.conversationId) {
          return conv.copyWith(unreadCount: 0);
        }
        return conv;
      }).toList();
      
      emit(currentState.copyWith(
        messages: updatedMessages,
        conversations: updatedConversations,
      ));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onTypingIndicatorChanged(
    TypingIndicatorChanged event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    
    // Update typing indicator
    emit(currentState.copyWith(
      typingIndicator: ChatTypingIndicatorModel(
        conversationId: event.conversationId,
        userId: event.userId,
        isTyping: event.isTyping,
        lastTypingAt: DateTime.now(),
      ),
    ));
  }

  Future<void> _onConversationCreated(
    ConversationCreated event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    
    try {
      // TODO: Create conversation via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final newConversation = ChatConversationModel(
        id: DateTime.now().millisecondsSinceEpoch,
        user1Id: 1, // Current user
        user2Id: event.otherUserId,
        lastMessageAt: DateTime.now(),
        createdAt: DateTime.now(),
        otherUser: event.otherUser,
        unreadCount: 0,
      );
      
      final updatedConversations = [newConversation, ...currentState.conversations];
      
      emit(currentState.copyWith(
        conversations: updatedConversations,
        selectedConversationId: newConversation.id,
      ));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onMessageLoadMoreRequested(
    MessageLoadMoreRequested event,
    Emitter<ChatState> emit,
  ) async {
    if (state is! ConversationsLoaded) return;
    
    final currentState = state as ConversationsLoaded;
    if (!currentState.hasMoreMessages || currentState.isLoadingMoreMessages) {
      return;
    }
    
    emit(currentState.copyWith(isLoadingMoreMessages: true));
    
    try {
      // TODO: Load more messages from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final olderMessages = [
        ChatMessageModel.mock().copyWith(
          id: currentState.messages.length + 1,
          content: 'This is an older message ${currentState.messages.length + 1}',
          createdAt: DateTime.now().subtract(Duration(hours: currentState.messages.length + 1)),
        ),
      ];
      
      final allMessages = [...currentState.messages, ...olderMessages];
      final hasMoreMessages = allMessages.length < 50; // Mock limit
      
      emit(currentState.copyWith(
        messages: allMessages,
        isLoadingMoreMessages: false,
        hasMoreMessages: hasMoreMessages,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isLoadingMoreMessages: false,
        error: e.toString(),
      ));
    }
  }
}
