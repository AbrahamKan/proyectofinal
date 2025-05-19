import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/post/domain/entities/post.dart';
import 'package:proyectofinal/features/post/domain/repos/post_repo.dart';
import 'package:proyectofinal/features/post/presentation/cubits/post_states.dart';

class PostCubit extends Cubit<PostState>{
  final PostRepo postRepo;
  

  PostCubit({
    required this.postRepo, 
    }) : super(PostsInitial());

    //create a new post
    Future<void> createPost(Post post, 
    {String? imagePath, Uint8List? imageBytes}) async{
      String? imageUrl;  

      try {
        //handle image upload for mobile
      if (imagePath != null){
        emit(PostUploading());
        //imageUrl = await storageRepo.uploadProfileImageMobile(imagePath, post.id);
      }

      //handle image upload for web
      else if (imageBytes != null){
        emit(PostUploading());
        //imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      //give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      //create post backend
      postRepo.createPost(newPost);
      } catch (e) {
        emit(PostsError("Failed to create post: $e"));
      }
    }

    //fetch all posts
    Future<void> fetchAllPosts() async {
      try {
        emit(PostsLoading());
        final posts = await postRepo.fetchAllPosts();
        emit(PostsLoaded(posts));
      } catch (e) {
        emit(PostsError("Failed to fetch post: $e"));
      }
    }

    //delete a post 
    Future<void> deletePost(String postId) async{
      try {
        
        await postRepo.deletePost(postId);

      } catch (e) {
        
      }
    }
}