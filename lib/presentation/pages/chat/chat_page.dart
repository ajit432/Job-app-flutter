import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/responsive_layout.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Messages'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement new chat
          },
          icon: const Icon(Icons.edit_outlined),
          tooltip: 'New message',
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: _buildChatsList()),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Column(
            children: [
              _buildSearchBar(),
              Expanded(child: _buildChatsList()),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        const Expanded(
          child: Center(
            child: Text('Select a conversation to start messaging'),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        SizedBox(
          width: 350,
          child: Column(
            children: [
              _buildSearchBar(),
              Expanded(child: _buildChatsList()),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        const Expanded(
          child: Center(
            child: Text('Select a conversation to start messaging'),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search conversations...',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          // TODO: Implement search
        },
      ),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildChatListItem(index);
      },
    );
  }

  Widget _buildChatListItem(int index) {
    final isOnline = index % 3 == 0;
    final hasUnread = index % 4 == 0;
    final unreadCount = hasUnread ? (index % 5) + 1 : 0;

    return ListTile(
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ),
          if (isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'John Doe $index',
              style: TextStyle(
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (hasUnread && unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(
        'Last message preview...',
        style: TextStyle(
          color: hasUnread ? AppColors.textPrimaryLight : AppColors.gray600,
          fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '2:30 PM',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: hasUnread ? AppColors.primary : AppColors.gray500,
              fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          if (hasUnread)
            const SizedBox(height: 4),
        ],
      ),
      onTap: () {
        if (context.isMobile) {
          _navigateToChatDetail(index);
        } else {
          // TODO: Show chat detail in the right panel
        }
      },
    );
  }

  void _navigateToChatDetail(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(chatIndex: index),
      ),
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  final int chatIndex;

  const ChatDetailPage({
    super.key,
    required this.chatIndex,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 16),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe ${widget.chatIndex}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Voice call
            },
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {
              // TODO: Video call
            },
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {
              // TODO: More options
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: 20,
      itemBuilder: (context, index) {
        final isMe = index % 3 != 0;
        return _buildMessageBubble(index, isMe);
      },
    );
  }

  Widget _buildMessageBubble(int index, bool isMe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            const CircleAvatar(
              radius: 12,
              child: Icon(Icons.person, size: 12),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.gray200,
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This is a sample message $index',
                    style: TextStyle(
                      color: isMe ? Colors.white : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '2:30 PM',
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white70 : AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.done_all,
              size: 16,
              color: AppColors.primary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // TODO: Attach file
            },
            icon: const Icon(Icons.attach_file),
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // TODO: Send message
      _messageController.clear();
      
      // Scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
