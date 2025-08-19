import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/comment_model.dart';
import '../../../core/constants/app_constants.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<FeedLoadRequested>(_onFeedLoadRequested);
    on<FeedRefreshRequested>(_onFeedRefreshRequested);
    on<FeedLoadMoreRequested>(_onFeedLoadMoreRequested);
    on<PostCreated>(_onPostCreated);
    on<PostLiked>(_onPostLiked);
    on<PostUnliked>(_onPostUnliked);
    on<PostSaved>(_onPostSaved);
    on<PostUnsaved>(_onPostUnsaved);
    on<PostInteractionChanged>(_onPostInteractionChanged);
    on<CommentAdded>(_onCommentAdded);
    on<CommentDeleted>(_onCommentDeleted);
  }

  Future<void> _onFeedLoadRequested(
    FeedLoadRequested event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    
    try {
      // TODO: Load feed from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final posts = [
        PostModel.mock(),
        PostModel.mock().copyWith(
          id: 2,
          content: 'Just completed my latest Flutter project! 📱',
          postType: PostType.personal,
        ),
        PostModel.mock().copyWith(
          id: 3,
          content: 'We are hiring! Check out our latest job openings.',
          postType: PostType.job,
          jobPost: JobPostModel.mock(),
        ),
      ];
      
      emit(FeedLoaded(
        posts: posts,
        hasReachedMax: false,
        currentPage: 1,
      ));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  Future<void> _onFeedRefreshRequested(
    FeedRefreshRequested event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    emit(currentState.copyWith(isRefreshing: true));
    
    try {
      // TODO: Refresh feed from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final posts = [
        PostModel.mock().copyWith(
          id: 999,
          content: 'New post at the top! 🆕',
        ),
        ...currentState.posts,
      ];
      
      emit(currentState.copyWith(
        posts: posts,
        isRefreshing: false,
        currentPage: 1,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isRefreshing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onFeedLoadMoreRequested(
    FeedLoadMoreRequested event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;
    
    emit(currentState.copyWith(isLoadingMore: true));
    
    try {
      // TODO: Load more posts from repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final morePosts = [
        PostModel.mock().copyWith(
          id: currentState.posts.length + 1,
          content: 'Loaded more content ${currentState.posts.length + 1}',
        ),
      ];
      
      final allPosts = [...currentState.posts, ...morePosts];
      final hasReachedMax = allPosts.length >= 20; // Mock limit
      
      emit(currentState.copyWith(
        posts: allPosts,
        isLoadingMore: false,
        hasReachedMax: hasReachedMax,
        currentPage: currentState.currentPage + 1,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onPostCreated(
    PostCreated event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Create post via repository
      await Future.delayed(const Duration(seconds: 1)); // Mock delay
      
      final newPost = event.post.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final updatedPosts = [newPost, ...currentState.posts];
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPostLiked(
    PostLiked event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Like post via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          final currentLikes = post.interactions?.likesCount ?? 0;
          final updatedInteractions = post.interactions?.copyWith(
                likesCount: currentLikes + 1,
                totalCount: (post.interactions?.totalCount ?? 0) + 1,
              ) ??
              const PostInteractionsModel(
                likesCount: 1,
                lovesCount: 0,
                supportsCount: 0,
                savesCount: 0,
                totalCount: 1,
              );
          
          return post.copyWith(
            interactions: updatedInteractions,
            isLiked: true,
          );
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPostUnliked(
    PostUnliked event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Unlike post via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          final currentLikes = post.interactions?.likesCount ?? 0;
          final updatedInteractions = post.interactions?.copyWith(
                likesCount: currentLikes > 0 ? currentLikes - 1 : 0,
                totalCount: (post.interactions?.totalCount ?? 0) > 0
                    ? (post.interactions?.totalCount ?? 0) - 1
                    : 0,
              ) ??
              const PostInteractionsModel(
                likesCount: 0,
                lovesCount: 0,
                supportsCount: 0,
                savesCount: 0,
                totalCount: 0,
              );
          
          return post.copyWith(
            interactions: updatedInteractions,
            isLiked: false,
          );
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPostSaved(
    PostSaved event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Save post via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          return post.copyWith(isSaved: true);
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPostUnsaved(
    PostUnsaved event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Unsave post via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          return post.copyWith(isSaved: false);
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onPostInteractionChanged(
    PostInteractionChanged event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Change interaction via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          var interactions = post.interactions ??
              const PostInteractionsModel(
                likesCount: 0,
                lovesCount: 0,
                supportsCount: 0,
                savesCount: 0,
                totalCount: 0,
              );
          
          switch (event.interactionType) {
            case InteractionType.like:
              interactions = interactions.copyWith(
                likesCount: interactions.likesCount + 1,
                totalCount: interactions.totalCount + 1,
              );
              break;
            case InteractionType.love:
              interactions = interactions.copyWith(
                lovesCount: interactions.lovesCount + 1,
                totalCount: interactions.totalCount + 1,
              );
              break;
            case InteractionType.support:
              interactions = interactions.copyWith(
                supportsCount: interactions.supportsCount + 1,
                totalCount: interactions.totalCount + 1,
              );
              break;
            case InteractionType.save:
              interactions = interactions.copyWith(
                savesCount: interactions.savesCount + 1,
                totalCount: interactions.totalCount + 1,
              );
              break;
          }
          
          return post.copyWith(interactions: interactions);
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onCommentAdded(
    CommentAdded event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Add comment via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          final currentCount = post.commentsCount ?? 0;
          return post.copyWith(commentsCount: currentCount + 1);
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }

  Future<void> _onCommentDeleted(
    CommentDeleted event,
    Emitter<FeedState> emit,
  ) async {
    if (state is! FeedLoaded) return;
    
    final currentState = state as FeedLoaded;
    
    try {
      // TODO: Delete comment via repository
      
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          final currentCount = post.commentsCount ?? 0;
          return post.copyWith(
            commentsCount: currentCount > 0 ? currentCount - 1 : 0,
          );
        }
        return post;
      }).toList();
      
      emit(currentState.copyWith(posts: updatedPosts));
    } catch (e) {
      emit(currentState.copyWith(error: e.toString()));
    }
  }
}
