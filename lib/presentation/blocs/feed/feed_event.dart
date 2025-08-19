part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class FeedLoadRequested extends FeedEvent {
  const FeedLoadRequested();
}

class FeedRefreshRequested extends FeedEvent {
  const FeedRefreshRequested();
}

class FeedLoadMoreRequested extends FeedEvent {
  const FeedLoadMoreRequested();
}

class PostCreated extends FeedEvent {
  final PostModel post;

  const PostCreated({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostLiked extends FeedEvent {
  final int postId;

  const PostLiked({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostUnliked extends FeedEvent {
  final int postId;

  const PostUnliked({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostSaved extends FeedEvent {
  final int postId;

  const PostSaved({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostUnsaved extends FeedEvent {
  final int postId;

  const PostUnsaved({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class PostInteractionChanged extends FeedEvent {
  final int postId;
  final InteractionType interactionType;

  const PostInteractionChanged({
    required this.postId,
    required this.interactionType,
  });

  @override
  List<Object?> get props => [postId, interactionType];
}

class CommentAdded extends FeedEvent {
  final int postId;
  final CommentModel comment;

  const CommentAdded({
    required this.postId,
    required this.comment,
  });

  @override
  List<Object?> get props => [postId, comment];
}

class CommentDeleted extends FeedEvent {
  final int postId;
  final int commentId;

  const CommentDeleted({
    required this.postId,
    required this.commentId,
  });

  @override
  List<Object?> get props => [postId, commentId];
}
