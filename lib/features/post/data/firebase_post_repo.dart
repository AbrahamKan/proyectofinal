import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectofinal/features/post/domain/entities/comment.dart';
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

  @override
  Future<void> toggleLikePost(String postId, String userId) async{
    try {
      
      //get the post document from firestore
      final postDoc = await postsCollection.doc(postId).get();

      if(postDoc.exists){
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        //check if user has already like this post
        final hasLiked = post.likes.contains(userId);

        //update the like list
        if(hasLiked){
          post.likes.remove(userId); //unlike
        } else {
          post.likes.add(userId); //like
        }

        //update the post document with the new like list
        await postsCollection.doc(postId).update({
          'likes' : post.likes,
        });
      } else {
        throw Exception("Post not found");
      }
    } catch (e) {
      throw Exception("Error togglinglike: $e");
    }
  }

  @override
  Future<void> addComment(String postId, Comment comment)async {
    try {
      
      //get post document
      final postDoc = await postsCollection.doc(postId).get();

      if (postDoc.exists){
        //convert json object
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        //add the new comment
        post.comments.add(comment);

        //update the post document 
        await postsCollection.doc(postId).update({
          'comments': post.comments.map((comment) => comment.toJson()).toString()
        });
      } else {
        throw Exception("Post not found");
      }

    } catch (e) {
      throw Exception("Error adding comment: $e");
    }
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async{
    try {
      
      //get post document
      final postDoc = await postsCollection.doc(postId).get();

      if (postDoc.exists){
        //convert json object
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        //add the new comment
        post.comments.removeWhere((comment) => comment.id == commentId);

        //update the post document 
        await postsCollection.doc(postId).update({
          'comments': post.comments.map((comment) => comment.toJson()).toString()
        });
      } else {
        throw Exception("Post not found");
      }

    } catch (e) {
      throw Exception("Error deleting comment: $e");
    }
  }
}