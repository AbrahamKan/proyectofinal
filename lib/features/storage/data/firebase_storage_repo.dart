import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyectofinal/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo{
  final FirebaseStorage storage = FirebaseStorage.instance;


  /*
  
  PROFILE PICTURES - upload images 

   */

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, "profile_images");
  }

 /*

  POST IMAGES - upload images

   */
  @override
    Future<String?> uploadPostImageMobile(String path, String fileName) {
      return _uploadFile(path, fileName, "post_images");
    }

  @override
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, "post_images");
  }


  //MOBILE PLATAFORMS (FILE)
  Future<String?> _uploadFile(
    String path, String fileName, String folder) async {
    try {

      //get file
      final file = File(path);

      // find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      //upload
      final uploadTask = await storageRef.putFile(file);

      //get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;

    } catch (e) {
      return null;
    }
  }

  //WEB PLATAFORMS (BYTES)
  Future<String?> _uploadFileBytes(
    Uint8List fileBytes, String fileName, String folder) async {
    try {

      // find place to store
      final storageRef = storage.ref().child('$folder/$fileName');

      //upload
      final uploadTask = await storageRef.putData(fileBytes);

      //get image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;

    } catch (e) {
      return null;
    }
  }
}