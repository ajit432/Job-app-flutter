import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../widgets/responsive_layout.dart';
import '../feed/feed_page.dart';
import '../jobs/jobs_page.dart';
import '../chat/chat_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FeedPage(),
    const JobsPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    NavigationItem(
      icon: Icons.work_outline,
      activeIcon: Icons.work,
      label: 'Jobs',
    ),
    NavigationItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Messages',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildSideNavigation(),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          _buildSideNavigation(isDesktop: true),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
          if (_selectedIndex == 0) _buildRightPanel(), // Show right panel only on feed
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: _navigationItems.map((item) {
        final index = _navigationItems.indexOf(item);
        final isSelected = _selectedIndex == index;
        
        return BottomNavigationBarItem(
          icon: Icon(isSelected ? item.activeIcon : item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }

  Widget _buildSideNavigation({bool isDesktop = false}) {
    final width = isDesktop ? 280.0 : 200.0;
    
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildSideNavHeader(isDesktop),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                final item = _navigationItems[index];
                final isSelected = _selectedIndex == index;
                
                return _buildSideNavItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  isDesktop: isDesktop,
                );
              },
            ),
          ),
          _buildSideNavFooter(isDesktop),
        ],
      ),
    );
  }

  Widget _buildSideNavHeader(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.work,
              color: AppColors.white,
              size: 24,
            ),
          ),
          if (isDesktop) ...[
            const SizedBox(width: 12),
            Text(
              'Job Portal',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSideNavItem({
    required NavigationItem item,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDesktop,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Icon(
          isSelected ? item.activeIcon : item.icon,
          color: isSelected ? AppColors.primary : AppColors.gray600,
        ),
        title: isDesktop
            ? Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.gray700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            : null,
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 16 : 12,
          vertical: 4,
        ),
      ),
    );
  }

  Widget _buildSideNavFooter(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        children: [
          if (isDesktop) ...[
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => _showSettingsDialog(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            const SizedBox(height: 8),
          ],
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: AppColors.error),
            title: isDesktop ? const Text('Logout', style: TextStyle(color: AppColors.error)) : null,
            onTap: () => _handleLogout(),
            contentPadding: EdgeInsets.symmetric(horizontal: isDesktop ? 16 : 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildRightPanelHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSuggestedConnections(),
                  const SizedBox(height: 24),
                  _buildTrendingJobs(),
                  const SizedBox(height: 24),
                  _buildRecentActivity(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanelHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  final newTheme = state.themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                  context.read<ThemeBloc>().add(ThemeChanged(themeMode: newTheme));
                },
                icon: Icon(
                  state.themeMode == ThemeMode.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                tooltip: 'Toggle theme',
              );
            },
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _showSettingsDialog(),
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedConnections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested Connections',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // TODO: Implement suggested connections list
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Suggested connections will appear here'),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Jobs',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // TODO: Implement trending jobs list
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Trending jobs will appear here'),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // TODO: Implement recent activity list
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Recent activity will appear here'),
          ),
        ),
      ],
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: state.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    final newTheme = value ? ThemeMode.dark : ThemeMode.light;
                    context.read<ThemeBloc>().add(ThemeChanged(themeMode: newTheme));
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          }
        },
        child: AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state is AuthLoading ? null : () {
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                  },
                  child: state is AuthLoading 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
