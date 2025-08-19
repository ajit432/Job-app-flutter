import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/responsive_layout.dart';
import '../../blocs/auth/auth_bloc.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ResponsiveBuilder(
        builder: (context, deviceType, width) {
          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: CustomScrollView(
              slivers: [
                _buildWelcomeSection(),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                if (deviceType == DeviceType.mobile) ...[
                  _buildCreatePostSection(),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                ],
                _buildFeedList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: context.isMobile ? _buildCreatePostFAB() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Home'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement search
          },
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement notifications
          },
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String userName = 'User';
            String userEmail = '';
            
            if (state is AuthAuthenticated) {
              final user = state.user;
              // Get name from profile if available, otherwise use email
              if (user.profile?.fullName != null && user.profile!.fullName!.isNotEmpty) {
                userName = user.profile!.fullName!;
              } else {
                // Extract name from email (part before @)
                userName = user.email.split('@').first;
                userName = userName.replaceAll('.', ' ').replaceAll('_', ' ');
                // Capitalize first letter of each word
                userName = userName.split(' ').map((word) => 
                  word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : word
                ).join(' ');
              }
              userEmail = user.email;
            }
            
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, $userName! 👋',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ready to explore new opportunities?',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.gray600,
                                ),
                              ),
                              if (userEmail.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  userEmail,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.gray500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionCard(
                            icon: Icons.work_outline,
                            title: 'Find Jobs',
                            subtitle: 'Browse opportunities',
                            onTap: () {
                              // TODO: Navigate to jobs
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildQuickActionCard(
                            icon: Icons.people_outline,
                            title: 'Network',
                            subtitle: 'Connect with peers',
                            onTap: () {
                              // TODO: Navigate to network
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.gray600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePostSection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _showCreatePostDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Share something...',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _showCreatePostDialog,
                  icon: const Icon(Icons.image_outlined),
                  tooltip: 'Add image',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildPostCard(index);
        },
        childCount: 10, // Mock data count
      ),
    );
  }

  Widget _buildPostCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            _buildPostContent(),
            _buildPostImage(),
            _buildPostActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Software Engineer at Tech Corp • 2h',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Show post options
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Just completed an amazing project using Flutter and Firebase! '
        'The combination of these technologies makes it so easy to build '
        'cross-platform applications with real-time features. '
        'What are your favorite tech stacks?',
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(
          Icons.image,
          size: 48,
          color: AppColors.gray400,
        ),
      ),
    );
  }

  Widget _buildPostActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildActionButton(
            icon: Icons.thumb_up_outlined,
            label: '24',
            onPressed: () {
              // TODO: Handle like
            },
          ),
          const SizedBox(width: 16),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            label: '5',
            onPressed: () {
              // TODO: Handle comment
            },
          ),
          const SizedBox(width: 16),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            onPressed: () {
              // TODO: Handle share
            },
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Handle bookmark
            },
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePostFAB() {
    return FloatingActionButton(
      onPressed: _showCreatePostDialog,
      child: const Icon(Icons.add),
    );
  }

  void _showCreatePostDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Create Post',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'What do you want to share?',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Add image
                      },
                      icon: const Icon(Icons.image_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Add video
                      },
                      icon: const Icon(Icons.videocam_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Add document
                      },
                      icon: const Icon(Icons.attach_file),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Create post
                        Navigator.of(context).pop();
                      },
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 2));
  }
}
