import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  final int id;
  final int userId;
  final int postId;
  final String content;
  final int? parentCommentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;
  final List<CommentModel>? replies;
  final int? repliesCount;
  final bool? canDelete;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.replies,
    this.repliesCount,
    this.canDelete,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        postId,
        content,
        parentCommentId,
        createdAt,
        updatedAt,
        user,
        replies,
        repliesCount,
        canDelete,
      ];

  CommentModel copyWith({
    int? id,
    int? userId,
    int? postId,
    String? content,
    int? parentCommentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
    List<CommentModel>? replies,
    int? repliesCount,
    bool? canDelete,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      replies: replies ?? this.replies,
      repliesCount: repliesCount ?? this.repliesCount,
      canDelete: canDelete ?? this.canDelete,
    );
  }

  static CommentModel mock() {
    return CommentModel(
      id: 1,
      userId: 2,
      postId: 1,
      content: 'Great post! Looking forward to seeing more updates.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      user: UserModel.mock().copyWith(
        id: 2,
        email: 'commenter@example.com',
        profile: UserModel.mock().profile?.copyWith(
          id: 2,
          userId: 2,
          fullName: 'Jane Smith',
        ),
      ),
      repliesCount: 2,
      canDelete: false,
    );
  }

  bool get isReply => parentCommentId != null;

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
