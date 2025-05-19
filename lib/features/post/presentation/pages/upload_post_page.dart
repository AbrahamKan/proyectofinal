import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/auth/domain/entities/app_user.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_cubit.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  //mobile image pick
 // PlataformFile? imagePickedFile;

  //web image pick
  Uint8List? webImage;

  //text controller
  final textController = TextEditingController();

  //current user
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  //get current user
  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  //pick image
  


//build iu
  @override
  Widget build(BuildContext context) {
    //scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}