import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/responsive_layout.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildJobsList(),
                _buildMyApplications(),
                _buildSavedJobs(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: context.isMobile ? _buildCreateJobFAB() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Jobs'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement filters
          },
          icon: const Icon(Icons.tune),
          tooltip: 'Filters',
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

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search jobs, companies, keywords...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onSubmitted: (value) {
              // TODO: Implement search
            },
          ),
          const SizedBox(height: 12),
          ResponsiveWrap(
            children: [
              _buildFilterChip('Remote', false),
              _buildFilterChip('Full-time', false),
              _buildFilterChip('Part-time', false),
              _buildFilterChip('Contract', false),
              _buildFilterChip('Internship', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Handle filter selection
      },
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.gray600,
      indicatorColor: AppColors.primary,
      tabs: const [
        Tab(text: 'All Jobs'),
        Tab(text: 'My Applications'),
        Tab(text: 'Saved'),
      ],
    );
  }

  Widget _buildJobsList() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ResponsiveGrid(
        mobileColumns: 1,
        tabletColumns: 2,
        desktopColumns: 2,
        children: List.generate(
          10,
          (index) => _buildJobCard(index),
        ),
      ),
    );
  }

  Widget _buildMyApplications() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildApplicationCard(index);
        },
      ),
    );
  }

  Widget _buildSavedJobs() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ResponsiveGrid(
        mobileColumns: 1,
        tabletColumns: 2,
        desktopColumns: 2,
        children: List.generate(
          3,
          (index) => _buildJobCard(index, isSaved: true),
        ),
      ),
    );
  }

  Widget _buildJobCard(int index, {bool isSaved = false}) {
    return Card(
      margin: const EdgeInsets.all(8),
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
                    borderRadius: BorderRadius.circular(12),
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
                      Text(
                        'Senior Flutter Developer',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Tech Solutions Inc.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Toggle bookmark
                  },
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.save : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'We are looking for an experienced Flutter developer to join our team...',
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildJobTag('Remote'),
                _buildJobTag('Full-time'),
                _buildJobTag('Senior Level'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  'San Francisco, CA',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                const Icon(Icons.attach_money, size: 16),
                const SizedBox(width: 4),
                Text(
                  '\$120k - \$150k',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  '2 days ago',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Apply for job
                },
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationCard(int index) {
    final statuses = ['Applied', 'Under Review', 'Interview', 'Rejected', 'Hired'];
    final status = statuses[index % statuses.length];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter Developer',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Tech Corp',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.getStatusColor(status.toLowerCase().replaceAll(' ', '_')).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: AppColors.getStatusColor(status.toLowerCase().replaceAll(' ', '_')),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Applied on: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'March 15, 2024',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: View application details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.gray700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCreateJobFAB() {
    return FloatingActionButton.extended(
      onPressed: () {
        // TODO: Navigate to create job page
      },
      icon: const Icon(Icons.add),
      label: const Text('Post Job'),
    );
  }

  Future<void> _handleRefresh() async {
    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 2));
  }
}
