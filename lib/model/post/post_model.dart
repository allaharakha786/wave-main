class PostModel {
  String ownerId;
  String postText;
  String postImage;
  List<String> tags;
  DateTime createdAt;
  List<CommentModel> comments;
  List<String> likes;
  List<String> shares;

  PostModel({
    required this.ownerId,
    required this.postText,
    required this.postImage,
    required this.tags,
    required this.createdAt,
    required this.comments,
    required this.likes,
    required this.shares,
  });

  // Convert Firestore map to PostModel
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      ownerId: map['ownerId'] ?? '',
      postText: map['postText'] ?? '',
      postImage: map['postImage'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      comments: (map['comments'] as List<dynamic>?)
          ?.map((commentMap) => CommentModel.fromMap(commentMap))
          .toList() ??
          [],
      likes: List<String>.from(map['likes'] ?? []),
      shares: List<String>.from(map['shares'] ?? []),
    );
  }

  // Convert PostModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'postText': postText,
      'postImage': postImage,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'likes': likes,
      'shares': shares,
    };
  }
}

class CommentModel {
  String userId;
  String commentText;
  DateTime createdAt;
  List<CommentModel> nestedComments;

  CommentModel({
    required this.userId,
    required this.commentText,
    required this.createdAt,
    required this.nestedComments,
  });

  // Convert Firestore map to CommentModel
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'] ?? '',
      commentText: map['commentText'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      nestedComments: (map['nestedComments'] as List<dynamic>?)
          ?.map((nestedMap) => CommentModel.fromMap(nestedMap))
          .toList() ??
          [],
    );
  }

  // Convert CommentModel to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'commentText': commentText,
      'createdAt': createdAt.toIso8601String(),
      'nestedComments': nestedComments.map((comment) => comment.toMap()).toList(),
    };
  }
}
