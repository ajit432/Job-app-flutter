import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: _buildProfileHeader(),
            actions: [
              IconButton(
                onPressed: _showEditProfile,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: _showSettings,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _buildProfileInfo(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(_tabController),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildAboutTab(),
          _buildExperienceTab(),
          _buildEducationTab(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeaderCard(),
          _buildProfileInfoCard(),
          _buildTabletContent(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left sidebar with profile info
        SizedBox(
          width: 300,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileHeaderCard(),
                const SizedBox(height: 16),
                _buildProfileInfoCard(),
                const SizedBox(height: 16),
                _buildQuickActions(),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        // Main content area
        Expanded(
          child: _buildDesktopContent(),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          // Banner image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Profile content
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Senior Flutter Developer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'San Francisco, CA',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
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
        ],
      ),
    );
  }

  Widget _buildProfileHeaderCard() {
    return Card(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  IconButton(
                    onPressed: _showEditProfile,
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: _showSettings,
                    icon: const Icon(Icons.settings, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Senior Flutter Developer',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'San Francisco, CA',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Posts', '24'),
              _buildStatItem('Followers', '1.2K'),
              _buildStatItem('Following', '340'),
              _buildStatItem('Connections', '500+'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Passionate Flutter developer with 5+ years of experience building cross-platform mobile applications. Love creating beautiful and efficient user experiences.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildSkillChip('Flutter'),
              _buildSkillChip('Dart'),
              _buildSkillChip('Firebase'),
              _buildSkillChip('REST APIs'),
              _buildSkillChip('State Management'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Posts', '24'),
                _buildStatItem('Followers', '1.2K'),
                _buildStatItem('Following', '340'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Passionate Flutter developer with 5+ years of experience building cross-platform mobile applications.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Skills',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildSkillChip('Flutter'),
                _buildSkillChip('Dart'),
                _buildSkillChip('Firebase'),
                _buildSkillChip('REST APIs'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.gray600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      labelStyle: const TextStyle(
        color: AppColors.primary,
        fontSize: 12,
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Edit Profile',
              onPressed: _showEditProfile,
              variant: ButtonVariant.outlined,
              isFullWidth: true,
              size: ButtonSize.small,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'View Resume',
              onPressed: () {
                // TODO: View resume
              },
              variant: ButtonVariant.text,
              isFullWidth: true,
              size: ButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'About'),
                Tab(text: 'Experience'),
                Tab(text: 'Education'),
              ],
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                children: [
                  _buildPostsTab(),
                  _buildAboutTab(),
                  _buildExperienceTab(),
                  _buildEducationTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopContent() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'About'),
                Tab(text: 'Experience'),
                Tab(text: 'Education'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildPostsTab(),
                _buildAboutTab(),
                _buildExperienceTab(),
                _buildEducationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Post ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is a sample post content. It could be about professional achievements, projects, or industry insights.',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_outlined, size: 16),
                      label: const Text('Like'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.comment_outlined, size: 16),
                      label: const Text('Comment'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined, size: 16),
                      label: const Text('Share'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'I am a passionate Flutter developer with over 5 years of experience in mobile app development. I specialize in creating beautiful, performant, and user-friendly applications for both iOS and Android platforms.',
          ),
          const SizedBox(height: 24),
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _buildContactItem(Icons.email, 'john.doe@example.com'),
          _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
          _buildContactItem(Icons.language, 'johndoe.dev'),
          _buildContactItem(Icons.location_on, 'San Francisco, CA'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.gray600),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Senior Flutter Developer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Tech Solutions Inc.',
                            style: TextStyle(color: AppColors.gray600),
                          ),
                          const Text(
                            '2021 - Present',
                            style: TextStyle(
                              color: AppColors.gray500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Led a team of 5 developers in building cross-platform mobile applications. Implemented complex UI components and integrated with various APIs and services.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEducationTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.school,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bachelor of Computer Science',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'University of California, Berkeley',
                            style: TextStyle(color: AppColors.gray600),
                          ),
                          const Text(
                            '2016 - 2020',
                            style: TextStyle(
                              color: AppColors.gray500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Graduated with honors. Specialized in mobile development and software engineering principles.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditProfile() {
    // TODO: Navigate to edit profile page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profile feature coming soon!')),
    );
  }

  void _showSettings() {
    // TODO: Navigate to settings page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings feature coming soon!')),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  _TabBarDelegate(this.tabController);

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        controller: tabController,
        tabs: const [
          Tab(text: 'Posts'),
          Tab(text: 'About'),
          Tab(text: 'Experience'),
          Tab(text: 'Education'),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
