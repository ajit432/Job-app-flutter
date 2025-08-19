part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<PostModel> posts;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final bool isRefreshing;
  final int currentPage;
  final String? error;

  const FeedLoaded({
    required this.posts,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.currentPage = 1,
    this.error,
  });

  @override
  List<Object?> get props => [
        posts,
        hasReachedMax,
        isLoadingMore,
        isRefreshing,
        currentPage,
        error,
      ];

  FeedLoaded copyWith({
    List<PostModel>? posts,
    bool? hasReachedMax,
    bool? isLoadingMore,
    bool? isRefreshing,
    int? currentPage,
    String? error,
  }) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      currentPage: currentPage ?? this.currentPage,
      error: error,
    );
  }

  bool get isEmpty => posts.isEmpty;
  bool get isNotEmpty => posts.isNotEmpty;
  int get totalPosts => posts.length;
}

class FeedError extends FeedState {
  final String message;

  const FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}
