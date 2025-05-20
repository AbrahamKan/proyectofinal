import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectofinal/features/post/domain/entities/comment.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime timestamp;
  final List<String> likes; //store uids
  final List<Comment> comments;

  Post ({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments
  });

  Post copyWith({String? imageUrl}) {
    return Post(
    id: id,
    userId: userId,
    userName: userName,
    text: text,
    imageUrl: imageUrl ?? this.imageUrl,
    timestamp: timestamp,
    likes: likes,
    comments: comments,
    );
  }

  //convert post -> json
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timestamp),
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  //convert json -> post
  factory Post.fromJson(Map<String, dynamic> json) {
  final commentsField = json['comments'];
  List<Comment> comments = [];

  if (commentsField is List) {
    comments = commentsField
        .map((commentJson) => Comment.fromJson(commentJson))
        .toList()
        .cast<Comment>();
  }

  return Post(
    id: json['id'] ?? '',
    userId: json['userId'] ?? '',
    userName: json['userName'] ?? '',
    text: json['text'] ?? '',
    imageUrl: (json['imageUrl'] != null && json['imageUrl'].toString().isNotEmpty)
        ? json['imageUrl']
        : 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?auto=format&fit=crop&w=800&q=60',
    timestamp: (json['timestamp'] as Timestamp).toDate(),
    likes: List<String>.from(json['likes'] ?? []),
    comments: comments,
  );
}


}