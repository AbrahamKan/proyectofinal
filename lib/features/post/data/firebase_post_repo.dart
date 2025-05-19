import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectofinal/features/post/domain/entities/post.dart';
import 'package:proyectofinal/features/post/domain/repos/post_repo.dart';

class FirebasePostRepo implements PostRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //store the posts in a collection called
  final CollectionReference postsCollection = 
  FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try {
      await postsCollection.doc(post.id).set(post.toJson());
    } 
    catch (e) {
      throw Exception("Error creating post: $e" );
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try {
      
      //get all posts with most recent posts
      final postsSnapshot = 
      await postsCollection.orderBy('timestamp', descending: true).get();

      //convert each
      final List<Post> allPost = postsSnapshot.docs
      .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

      return allPost;
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }

  @override
  Future<List<Post>> fetchPostsByUserId(String userId) async {
    try {
      
      //fetch posts
      final postsSnapshot = 
      await postsCollection.where('userId', isEqualTo: userId).get();

      //convert firestore documents
      final userPosts = postsSnapshot.docs
      .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
      .toList();

      return userPosts;
    } catch (e) {
      throw Exception("Error fetching posts by user: $e");
    }
  }
}